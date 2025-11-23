use std::collections::VecDeque;

impl Solution {
    pub fn deck_revealed_increasing(deck: Vec<i32>) -> Vec<i32> {
        let mut deck = deck;
        deck.sort_unstable();
        let mut queue = VecDeque::new();
        for i in 0..deck.len() {
            queue.push_back(i);
        }
        let mut res = vec![0; deck.len()];
        for &card in deck.iter() {
            if let Some(idx) = queue.pop_front() {
                res[idx] = card;
            }
            if let Some(next) = queue.pop_front() {
                queue.push_back(next);
            }
        }
        res
    }
}