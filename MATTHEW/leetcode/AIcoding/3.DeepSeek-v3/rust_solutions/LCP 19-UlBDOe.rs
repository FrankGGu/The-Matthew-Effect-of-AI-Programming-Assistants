impl Solution {
    pub fn minimum_operations(leaves: String) -> i32 {
        let n = leaves.len();
        let leaves: Vec<char> = leaves.chars().collect();
        let mut dp = vec![vec![0; 3]; n];

        dp[0][0] = if leaves[0] == 'y' { 1 } else { 0 };
        dp[0][1] = i32::MAX;
        dp[0][2] = i32::MAX;
        dp[1][2] = i32::MAX;

        for i in 1..n {
            let is_red = if leaves[i] == 'r' { 0 } else { 1 };
            let is_yellow = if leaves[i] == 'y' { 0 } else { 1 };

            dp[i][0] = dp[i-1][0] + is_red;
            if i >= 1 {
                dp[i][1] = std::cmp::min(dp[i-1][0], dp[i-1][1]) + is_yellow;
            }
            if i >= 2 {
                dp[i][2] = std::cmp::min(dp[i-1][1], dp[i-1][2]) + is_red;
            }
        }

        dp[n-1][2]
    }
}