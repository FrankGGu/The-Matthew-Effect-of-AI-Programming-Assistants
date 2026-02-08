impl Solution {
    pub fn min_sub_array_len(target: i32, nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut min_len = i32::MAX;
        let mut current_sum = 0;
        let mut left = 0;

        for right in 0..n {
            current_sum += nums[right];

            while current_sum >= target {
                min_len = min_len.min((right - left + 1) as i32);
                current_sum -= nums[left];
                left += 1;
            }
        }

        if min_len == i32::MAX {
            0
        } else {
            min_len
        }
    }
}