impl Solution {
    pub fn minimum_total(triangle: Vec<Vec<i32>>) -> i32 {
        let mut dp = triangle.last().unwrap().clone();
        for row in triangle.iter().rev().skip(1) {
            for j in 0..row.len() {
                dp[j] = row[j] + dp[j].min(dp[j + 1]);
            }
        }
        dp[0]
    }
}