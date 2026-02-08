use std::collections::HashMap;

impl Solution {
    pub fn subarray_sum(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut sum = 0;
        let mut prefix_sums: HashMap<i32, i32> = HashMap::new();
        prefix_sums.insert(0, 1);

        for num in nums {
            sum += num;
            if prefix_sums.contains_key(&(sum - k)) {
                count += prefix_sums.get(&(sum - k)).unwrap();
            }
            *prefix_sums.entry(sum).or_insert(0) += 1;
        }

        count
    }
}