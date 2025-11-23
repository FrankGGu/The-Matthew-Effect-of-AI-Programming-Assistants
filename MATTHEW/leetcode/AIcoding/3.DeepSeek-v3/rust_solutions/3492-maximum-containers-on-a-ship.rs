impl Solution {
    pub fn maximum_containers(containers: Vec<i32>, items: Vec<i32>, cargo_size: i32) -> i32 {
        let mut dp = vec![0; (cargo_size + 1) as usize];

        for i in 0..containers.len() {
            let weight = items[i];
            let value = containers[i];
            for w in (weight..=cargo_size).rev() {
                dp[w as usize] = dp[w as usize].max(dp[(w - weight) as usize] + value);
            }
        }

        dp[cargo_size as usize]
    }
}