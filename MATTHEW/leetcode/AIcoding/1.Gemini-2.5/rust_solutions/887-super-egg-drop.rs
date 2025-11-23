struct Solution;
impl Solution {
    pub fn super_egg_drop(k_eggs: i32, n_floors: i32) -> i32 {
        let mut dp: Vec<i32> = vec![0; k_eggs as usize + 1];
        let mut m = 0;

        while dp[k_eggs as usize] < n_floors {
            m += 1;
            let mut prev_dp_k_minus_1 = 0; 
            for k in 1..=k_eggs as usize {
                let temp = dp[k];
                dp[k] = prev_dp_k_minus_1 + dp[k] + 1;
                prev_dp_k_minus_1 = temp;
            }
        }

        m
    }
}