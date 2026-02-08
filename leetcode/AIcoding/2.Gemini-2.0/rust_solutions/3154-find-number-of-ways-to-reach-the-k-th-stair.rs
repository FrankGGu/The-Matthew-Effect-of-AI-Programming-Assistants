impl Solution {
    pub fn find_number_of_ways_to_reach_kth_stair(n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut dp = vec![0; k + 1];
        dp[0] = 1;
        for i in 1..=k {
            for j in 1..=std::cmp::min(i, n) {
                dp[i] += dp[i - j];
            }
        }
        dp[k]
    }
}