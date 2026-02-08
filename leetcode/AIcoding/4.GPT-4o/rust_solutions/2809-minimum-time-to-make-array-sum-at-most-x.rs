impl Solution {
    pub fn min_time(nums: Vec<i32>, x: i32) -> i32 {
        let total: i32 = nums.iter().sum();
        let target = total - x;
        if target < 0 {
            return -1;
        }

        let mut prefix_sum = std::collections::HashMap::new();
        prefix_sum.insert(0, -1);
        let mut curr_sum = 0;
        let mut max_len = -1;

        for (i, &num) in nums.iter().enumerate() {
            curr_sum += num;
            if let Some(&prev_index) = prefix_sum.get(&(curr_sum - target)) {
                max_len = max_len.max(i as i32 - prev_index);
            }
            prefix_sum.insert(curr_sum, i as i32);
        }

        if max_len == -1 {
            return -1;
        }

        (nums.len() as i32 - max_len) as i32
    }
}