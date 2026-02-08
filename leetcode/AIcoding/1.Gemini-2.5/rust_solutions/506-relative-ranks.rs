impl Solution {
    pub fn find_relative_ranks(scores: Vec<i32>) -> Vec<String> {
        let n = scores.len();
        let mut indexed_scores: Vec<(i32, usize)> = scores
            .into_iter()
            .enumerate()
            .map(|(i, score)| (score, i))
            .collect();

        indexed_scores.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let mut result: Vec<String> = vec![String::new(); n];

        for (rank, &(score, original_index)) in indexed_scores.iter().enumerate() {
            let rank_str = match rank {
                0 => "Gold Medal".to_string(),
                1 => "Silver Medal".to_string(),
                2 => "Bronze Medal".to_string(),
                _ => (rank + 1).to_string(),
            };
            result[original_index] = rank_str;
        }

        result
    }
}