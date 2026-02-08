impl Solution {
    pub fn maximum_energy(energy: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = energy.len();
        let mut dp = energy.clone();
        for i in (0..n).rev() {
            if i + k < n {
                dp[i] += dp[i + k];
            }
        }
        *dp.iter().max().unwrap()
    }
}