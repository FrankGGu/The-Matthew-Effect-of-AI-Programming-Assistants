impl Solution {
    pub fn find_relative_ranks(score: Vec<i32>) -> Vec<String> {
        let mut sorted_scores: Vec<(i32, usize)> = score.iter().enumerate().map(|(i, &s)| (s, i)).collect();
        sorted_scores.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let mut ranks = vec!["".to_string(); score.len()];
        for (rank, &(_, idx)) in sorted_scores.iter().enumerate() {
            ranks[idx] = match rank {
                0 => "Gold Medal".to_string(),
                1 => "Silver Medal".to_string(),
                2 => "Bronze Medal".to_string(),
                _ => (rank + 1).to_string(),
            };
        }
        ranks
    }
}