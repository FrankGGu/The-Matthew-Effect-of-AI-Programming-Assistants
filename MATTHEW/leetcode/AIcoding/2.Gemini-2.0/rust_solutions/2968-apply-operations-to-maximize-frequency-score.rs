impl Solution {
    pub fn max_frequency_score(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }

        let mut ans = 0;
        for i in 0..n {
            let mut left = 0;
            let mut right = i;
            while left <= right {
                let mid = left + (right - left) / 2;
                let cost = (i - mid + 1) as i64 * nums[i] as i64 - (prefix_sum[i + 1] - prefix_sum[mid]);
                if cost <= k as i64 {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }

            let left_bound = left;

            left = i;
            right = n - 1;

            while left <= right {
                let mid = left + (right - left) / 2;
                let cost = prefix_sum[mid + 1] - prefix_sum[i] - (mid - i + 1) as i64 * nums[i] as i64;
                if cost <= k as i64 {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            let right_bound = right;

            ans = ans.max(right_bound as i32 - left_bound as i32 + 1);
        }

        ans
    }
}