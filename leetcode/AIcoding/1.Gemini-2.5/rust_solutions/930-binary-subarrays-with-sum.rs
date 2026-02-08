use std::collections::HashMap;

impl Solution {
    pub fn num_subarrays_with_sum(nums: Vec<i32>, goal: i32) -> i32 {
        let mut count = 0;
        let mut current_sum = 0;
        let mut prefix_sums: HashMap<i32, i32> = HashMap::new();

        prefix_sums.insert(0, 1);

        for num in nums {
            current_sum += num;

            if let Some(&freq) = prefix_sums.get(&(current_sum - goal)) {
                count += freq;
            }

            *prefix_sums.entry(current_sum).or_insert(0) += 1;
        }

        count
    }
}