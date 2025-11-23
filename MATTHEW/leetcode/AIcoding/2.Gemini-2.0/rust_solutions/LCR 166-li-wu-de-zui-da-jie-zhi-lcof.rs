impl Solution {
    pub fn get_max_value(jewels: Vec<Vec<i32>>, capacity: i32) -> i32 {
        let mut dp = vec![0; (capacity + 1) as usize];
        for jewel in jewels {
            let weight = jewel[0];
            let value = jewel[1];
            for j in (weight..=capacity).rev() {
                dp[j as usize] = dp[j as usize].max(dp[(j - weight) as usize] + value);
            }
        }
        dp[capacity as usize]
    }
}