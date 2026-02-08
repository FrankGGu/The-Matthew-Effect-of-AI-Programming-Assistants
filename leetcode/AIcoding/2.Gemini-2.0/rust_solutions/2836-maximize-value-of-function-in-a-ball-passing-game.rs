impl Solution {
    pub fn max_value_of_function(mut receiver: Vec<i32>, k: i64) -> i64 {
        let n = receiver.len();
        let mut dp = vec![vec![0; n]; 64];

        for i in 0..n {
            dp[0][i] = (receiver[i] - 1) as usize;
        }

        for i in 1..64 {
            for j in 0..n {
                dp[i][j] = dp[i - 1][dp[i - 1][j]];
            }
        }

        let mut ans = vec![0; n];
        for i in 0..n {
            let mut curr = i;
            let mut steps = k;
            let mut sum = 0;

            for j in 0..64 {
                if (steps & (1 << j)) != 0 {
                    sum += (curr + 1) as i64;
                    curr = dp[j][curr];
                }
            }

            sum += (curr + 1) as i64;
            ans[i] = sum;
        }

        *ans.iter().max().unwrap()
    }
}