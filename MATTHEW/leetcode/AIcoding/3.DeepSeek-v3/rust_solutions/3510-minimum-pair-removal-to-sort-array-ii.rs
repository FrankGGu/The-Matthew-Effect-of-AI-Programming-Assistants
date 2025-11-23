impl Solution {
    pub fn min_deletion_size(nums: Vec<String>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        let m = nums[0].len();
        let mut dp = vec![1; m];
        for i in 1..m {
            for j in 0..i {
                let mut valid = true;
                for num in &nums {
                    if num.as_bytes()[j] > num.as_bytes()[i] {
                        valid = false;
                        break;
                    }
                }
                if valid {
                    dp[i] = dp[i].max(dp[j] + 1);
                }
            }
        }
        (m - dp.into_iter().max().unwrap_or(0)) as i32
    }
}