impl Solution {
    pub fn min_size_subarray(nums: Vec<i32>, target: i32) -> i32 {
        let n = nums.len();
        let mut sum: i64 = 0;
        for &num in &nums {
            sum += num as i64;
        }

        let mut k = target as i64 / sum;
        let mut rem = target as i64 % sum;

        let mut ans = if k > 0 { k as i32 * n as i32 } else { i32::MAX };

        let mut left = 0;
        let mut curr_sum: i64 = 0;
        let mut min_len = i32::MAX;

        for right in 0..2 * n {
            curr_sum += nums[right % n] as i64;

            while curr_sum > rem {
                curr_sum -= nums[left % n] as i64;
                left += 1;
            }

            if curr_sum == rem {
                min_len = min_len.min((right - left + 1) as i32);
            }
        }

        if ans == i32::MAX && min_len == i32::MAX {
            return -1;
        }

        if min_len != i32::MAX {
            ans = ans.saturating_add(min_len);
        } else {
            ans = -1;
        }

        if k == 0 && ans == -1 {
            let mut left = 0;
            let mut curr_sum: i64 = 0;
            let mut min_len = i32::MAX;

            for right in 0..n {
                curr_sum += nums[right % n] as i64;

                while curr_sum > rem {
                    curr_sum -= nums[left % n] as i64;
                    left += 1;
                }

                if curr_sum == rem {
                    min_len = min_len.min((right - left + 1) as i32);
                }
            }

            if min_len != i32::MAX {
                ans = min_len;
            }
        }

        if ans == i32::MAX{
            return -1;
        }
        ans
    }
}