impl Solution {
    pub fn num_ways(n: i32, relation: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![vec![0; n]; k + 1];
        dp[0][0] = 1;

        for i in 0..k {
            for edge in &relation {
                let src = edge[0] as usize;
                let dst = edge[1] as usize;
                dp[i + 1][dst] += dp[i][src];
            }
        }

        dp[k][n - 1]
    }
}