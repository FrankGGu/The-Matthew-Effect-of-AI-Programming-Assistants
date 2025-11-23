impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn best_hand(mut hands: Vec<String>) -> String {
        let mut counts = HashMap::new();
        for hand in &hands {
            for c in hand.chars() {
                *counts.entry(c).or_insert(0) += 1;
            }
        }

        let max_count = counts.values().max().unwrap();

        match *max_count {
            5 => "Flush".to_string(),
            4 => "Four of a Kind".to_string(),
            3 => "Three of a Kind".to_string(),
            2 => "Pair".to_string(),
            _ => "High Card".to_string(),
        }
    }
}
}