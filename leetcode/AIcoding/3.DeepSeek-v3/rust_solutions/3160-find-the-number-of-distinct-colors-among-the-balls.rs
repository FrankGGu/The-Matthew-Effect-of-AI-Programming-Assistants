use std::collections::HashSet;

impl Solution {
    pub fn number_of_distinct_colors(balls: Vec<Vec<i32>>) -> i32 {
        let mut colors = HashSet::new();
        for ball in balls {
            colors.insert(ball[1]);
        }
        colors.len() as i32
    }
}