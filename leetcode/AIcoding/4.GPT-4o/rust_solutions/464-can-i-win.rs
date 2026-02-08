impl Solution {
    pub fn can_i_win(max_amount: i32, desired_total: i32) -> bool {
        if desired_total <= 0 {
            return true;
        }
        if (max_amount * (max_amount + 1)) / 2 < desired_total {
            return false;
        }
        let mut dp = vec![-1; desired_total as usize + 1];
        Self::can_win_helper(desired_total, max_amount, &mut dp)
    }

    fn can_win_helper(desired_total: i32, max_amount: i32, dp: &mut Vec<i32>) -> bool {
        if desired_total <= 0 {
            return false;
        }
        if dp[desired_total as usize] != -1 {
            return dp[desired_total as usize] == 1;
        }
        for i in 1..=max_amount {
            if desired_total - i >= 0 && !Self::can_win_helper(desired_total - i, max_amount, dp) {
                dp[desired_total as usize] = 1;
                return true;
            }
        }
        dp[desired_total as usize] = 0;
        false
    }
}