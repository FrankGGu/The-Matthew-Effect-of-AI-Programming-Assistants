impl Solution {
    pub fn apply_operations(nums: Vec<i32>, k: i64) -> i32 {
        let n = nums.len();
        let mut arr: Vec<i32> = Vec::new();
        let mut i = 0;

        while i < n - 1 {
            if nums[i] == nums[i + 1] {
                arr.push(nums[i] * 2);
                i += 2;
            } else {
                arr.push(nums[i]);
                i += 1;
            }
        }

        if i == n - 1 {
            arr.push(nums[i]);
        }

        let m = arr.len();
        let mut dp = vec![vec![0; m + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=i {
                dp[i][j] = std::cmp::max(dp[i - 1][j - 1] + arr[i - 1] as i64, dp[i - 1][j]);
            }
        }

        for j in (0..=m).rev() {
            if dp[m][j] >= k {
                return j as i32;
            }
        }

        0
    }
}