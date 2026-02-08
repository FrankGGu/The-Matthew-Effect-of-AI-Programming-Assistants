use std::collections::HashMap;

impl Solution {
    pub fn subarray_sum(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut current_sum = 0;
        let mut sum_frequencies: HashMap<i32, i32> = HashMap::new();
        sum_frequencies.insert(0, 1);

        for num in nums {
            current_sum += num;
            if let Some(&freq) = sum_frequencies.get(&(current_sum - k)) {
                count += freq;
            }
            *sum_frequencies.entry(current_sum).or_insert(0) += 1;
        }

        count
    }
}