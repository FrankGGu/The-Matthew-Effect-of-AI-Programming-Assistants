impl Solution {
    pub fn num_ways(n: i32, relation: Vec<Vec<i32>>, k: i32) -> i32 {
        let n_usize = n as usize;
        let k_usize = k as usize;

        let mut dp: Vec<i64> = vec![0; n_usize];

        dp[0] = 1;

        for _step in 0..k_usize {
            let mut new_dp: Vec<i64> = vec![0; n_usize];

            for r in &relation {
                let u = r[0] as usize;
                let v = r[1] as usize;
                new_dp[v] += dp[u];
            }
            dp = new_dp;
        }

        dp[n_usize - 1] as i32
    }
}