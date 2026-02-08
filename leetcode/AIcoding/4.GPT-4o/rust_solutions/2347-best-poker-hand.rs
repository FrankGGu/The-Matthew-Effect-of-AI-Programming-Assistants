pub fn best_poker_hand(ranks: Vec<i32>, suits: Vec<char>) -> String {
    use std::collections::HashMap;

    let mut rank_count = HashMap::new();
    let mut suit_count = HashMap::new();

    for &rank in &ranks {
        *rank_count.entry(rank).or_insert(0) += 1;
    }

    for &suit in &suits {
        *suit_count.entry(suit).or_insert(0) += 1;
    }

    if suit_count.values().any(|&count| count >= 5) {
        return "Flush".to_string();
    }

    let max_rank = *rank_count.values().max().unwrap_or(&0);
    if max_rank >= 3 {
        return "Three of a Kind".to_string();
    }

    if max_rank == 2 {
        if rank_count.values().filter(|&&count| count == 2).count() > 1 {
            return "Two Pair".to_string();
        }
        return "One Pair".to_string();
    }

    "High Card".to_string()
}