impl Solution {
    pub fn expect_number(scores: Vec<i32>) -> i32 {
        let mut unique_scores = std::collections::HashSet::new();
        for score in scores {
            unique_scores.insert(score);
        }
        unique_scores.len() as i32
    }
}