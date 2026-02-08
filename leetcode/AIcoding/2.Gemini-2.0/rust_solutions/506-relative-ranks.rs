impl Solution {
    pub fn relative_ranks(score: Vec<i32>) -> Vec<String> {
        let mut sorted_score = score.clone();
        sorted_score.sort_by(|a, b| b.cmp(a));

        let mut result = vec![String::new(); score.len()];
        for (i, &s) in score.iter().enumerate() {
            let rank_index = sorted_score.iter().position(|&x| x == s).unwrap();
            result[i] = match rank_index {
                0 => "Gold Medal".to_string(),
                1 => "Silver Medal".to_string(),
                2 => "Bronze Medal".to_string(),
                _ => (rank_index + 1).to_string(),
            };
        }

        result
    }
}