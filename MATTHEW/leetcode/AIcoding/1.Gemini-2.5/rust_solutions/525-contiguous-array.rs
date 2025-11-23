use std::collections::HashMap;

impl Solution {
    pub fn find_max_length(nums: Vec<i32>) -> i32 {
        let mut max_len = 0;
        let mut current_sum = 0;
        let mut sum_map: HashMap<i32, i32> = HashMap::new();

        sum_map.insert(0, -1); // Initialize with sum 0 at index -1 to handle subarrays starting from index 0

        for (i, &num) in nums.iter().enumerate() {
            if num == 0 {
                current_sum -= 1;
            } else {
                current_sum += 1;
            }

            if let Some(&prev_index) = sum_map.get(&current_sum) {
                max_len = max_len.max(i as i32 - prev_index);
            } else {
                sum_map.insert(current_sum, i as i32);
            }
        }

        max_len
    }
}