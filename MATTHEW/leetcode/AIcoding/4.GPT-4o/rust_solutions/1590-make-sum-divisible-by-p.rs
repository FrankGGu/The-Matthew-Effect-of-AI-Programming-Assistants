impl Solution {
    pub fn min_subarray(nums: Vec<i32>, p: i32) -> i32 {
        let total_sum: i32 = nums.iter().sum();
        let target = total_sum % p;
        if target == 0 { return 0; }

        let mut min_length = nums.len() as i32 + 1;
        let mut prefix_sum = 0;
        let mut last_index = std::collections::HashMap::new();
        last_index.insert(0, -1);

        for (i, &num) in nums.iter().enumerate() {
            prefix_sum = (prefix_sum + num) % p;
            if let Some(&prev_index) = last_index.get(&(prefix_sum + p - target) % p) {
                min_length = min_length.min(i as i32 - prev_index);
            }
            last_index.insert(prefix_sum, i as i32);
        }

        if min_length == nums.len() as i32 + 1 { -1 } else { min_length }
    }
}