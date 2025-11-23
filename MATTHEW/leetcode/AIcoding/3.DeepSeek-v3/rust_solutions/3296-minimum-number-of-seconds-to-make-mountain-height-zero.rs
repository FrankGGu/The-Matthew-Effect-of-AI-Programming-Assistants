impl Solution {
    pub fn minimum_seconds_to_make_mountain_zero(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left = vec![0; n];
        let mut right = vec![0; n];

        for i in 1..n {
            if nums[i] > nums[i - 1] {
                left[i] = left[i - 1] + 1;
            } else {
                left[i] = 0;
            }
        }

        for i in (0..n - 1).rev() {
            if nums[i] > nums[i + 1] {
                right[i] = right[i + 1] + 1;
            } else {
                right[i] = 0;
            }
        }

        let mut max_len = 0;
        for i in 0..n {
            if left[i] > 0 && right[i] > 0 {
                max_len = max_len.max(left[i] + right[i] + 1);
            }
        }

        if max_len == 0 {
            return 0;
        }

        (n - max_len) as i32
    }
}