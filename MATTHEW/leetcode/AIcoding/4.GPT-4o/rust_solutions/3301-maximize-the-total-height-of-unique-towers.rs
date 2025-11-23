impl Solution {
    pub fn max_tower_height(A: Vec<i32>) -> i32 {
        let mut heights = A;
        heights.sort_unstable();
        let mut dp = vec![0; heights.len() + 1];

        for i in 1..=heights.len() {
            for j in (0..i).rev() {
                dp[i] = dp[i].max(dp[j] + heights[i - 1] * (i as i32));
            }
        }

        *dp.iter().max().unwrap()
    }
}