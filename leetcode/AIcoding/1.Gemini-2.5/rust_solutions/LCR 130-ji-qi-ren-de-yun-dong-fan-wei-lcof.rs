impl Solution {
    pub fn wardrobe_organization(values: Vec<i32>, weights: Vec<i32>, wardrobe_capacity: i32) -> i32 {
        let n = values.len();
        let capacity = wardrobe_capacity as usize;
        let mut dp = vec![0; capacity + 1];

        for i in 0..n {
            let weight = weights[i] as usize;
            let value = values[i];
            for w in (weight..=capacity).rev() {
                dp[w] = dp[w].max(dp[w - weight] + value);
            }
        }
        dp[capacity]
    }
}