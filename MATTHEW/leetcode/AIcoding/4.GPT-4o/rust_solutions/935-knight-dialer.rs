impl Solution {
    pub fn knight_dialer(n: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let moves = vec![
            vec![4, 6],
            vec![6, 8],
            vec![7, 9],
            vec![4, 8],
            vec![0, 3, 9],
            vec![],
            vec![0, 1, 7],
            vec![2, 6],
            vec![1, 3],
            vec![2, 4],
        ];
        let mut dp = vec![vec![0; 10]; n as usize + 1];

        for i in 0..10 {
            dp[1][i] = 1;
        }

        for step in 2..=n {
            for num in 0..10 {
                for &next in &moves[num] {
                    dp[step][next] = (dp[step][next] + dp[step - 1][num]) % mod_val;
                }
            }
        }

        let mut result = 0;
        for i in 0..10 {
            result = (result + dp[n as usize][i]) % mod_val;
        }

        result
    }
}