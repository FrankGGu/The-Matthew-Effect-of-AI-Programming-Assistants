impl Solution {
    pub fn min_operations(nums: Vec<i32>, x: i32) -> i32 {
        let total_sum: i32 = nums.iter().sum();
        let n = nums.len() as i32;

        let target_sum = total_sum - x;

        if target_sum < 0 {
            return -1;
        }

        let mut max_len = -1;
        let mut current_sum = 0;
        let mut left = 0;

        for right in 0..n {
            current_sum += nums[right as usize];

            while current_sum > target_sum && left <= right {
                current_sum -= nums[left as usize];
                left += 1;
            }

            if current_sum == target_sum {
                max_len = max_len.max(right - left + 1);
            }
        }

        if max_len == -1 {
            -1
        } else {
            n - max_len
        }
    }
}