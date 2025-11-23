impl Solution {
    pub fn find_relative_ranks(score: Vec<i32>) -> Vec<String> {
        let mut indexed_scores: Vec<(usize, i32)> = score.iter().enumerate().map(|(i, &s)| (i, s)).collect();
        indexed_scores.sort_unstable_by(|a, b| b.1.cmp(&a.1));

        let mut result = vec![String::new(); score.len()];
        for (rank, &(index, _)) in indexed_scores.iter().enumerate() {
            result[index] = match rank {
                0 => "Gold Medal".to_string(),
                1 => "Silver Medal".to_string(),
                2 => "Bronze Medal".to_string(),
                _ => (rank + 1).to_string(),
            };
        }
        result
    }
}