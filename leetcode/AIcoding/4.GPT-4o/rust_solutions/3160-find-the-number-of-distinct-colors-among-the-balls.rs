impl Solution {
    pub fn distinct_colors(balls: Vec<i32>) -> i32 {
        let mut colors = std::collections::HashSet::new();
        for ball in balls {
            colors.insert(ball);
        }
        colors.len() as i32
    }
}