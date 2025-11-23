use std::collections::HashMap;

impl Solution {
    pub fn best_hand(ranks: Vec<i32>, suits: Vec<char>) -> String {
        let mut suit_counts = HashMap::new();
        for &suit in &suits {
            *suit_counts.entry(suit).or_insert(0) += 1;
        }
        if suit_counts.len() == 1 {
            return "Flush".to_string();
        }

        let mut rank_counts = HashMap::new();
        for &rank in &ranks {
            *rank_counts.entry(rank).or_insert(0) += 1;
        }
        let max_count = rank_counts.values().max().unwrap_or(&0);
        if *max_count >= 3 {
            return "Three of a Kind".to_string();
        } else if *max_count == 2 {
            return "Pair".to_string();
        } else {
            return "High Card".to_string();
        }
    }
}