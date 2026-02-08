use std::collections::HashMap;

impl Solution {
    pub fn best_hand(ranks: Vec<i32>, suits: Vec<char>) -> String {
        // 1. Check for Flush: all cards have the same suit.
        let is_flush = suits[0] == suits[1] &&
                       suits[0] == suits[2] &&
                       suits[0] == suits[3] &&
                       suits[0] == suits[4];

        if is_flush {
            return "Flush".to_string();
        }

        // 2. Count rank occurrences to check for Three of a Kind, Pair, or High Card.
        let mut rank_counts: HashMap<i32, i32> = HashMap::new();
        for rank in ranks {
            *rank_counts.entry(rank).or_insert(0) += 1;
        }

        // Find the maximum count of any single rank.
        // Since there are always 5 cards, rank_counts will not be empty,
        // so unwrap() is safe.
        let max_rank_count = *rank_counts.values().max().unwrap();

        // 3. Check for Three of a Kind: three cards have the same rank.
        if max_rank_count >= 3 {
            return "Three of a Kind".to_string();
        }

        // 4. Check for Pair: two cards have the same rank.
        if max_rank_count >= 2 {
            return "Pair".to_string();
        }

        // 5. If none of the above, it's a High Card hand.
        "High Card".to_string()
    }
}