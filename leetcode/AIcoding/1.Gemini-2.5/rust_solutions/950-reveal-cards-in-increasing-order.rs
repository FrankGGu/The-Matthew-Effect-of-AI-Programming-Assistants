use std::collections::VecDeque;

impl Solution {
    pub fn deck_revealed_increasing(mut deck: Vec<i32>) -> Vec<i32> {
        let n = deck.len();
        deck.sort_unstable();

        let mut result_deck: VecDeque<i32> = VecDeque::with_capacity(n);

        for card in deck.into_iter().rev() {
            if let Some(last_card) = result_deck.pop_back() {
                result_deck.push_front(last_card);
            }
            result_deck.push_front(card);
        }

        result_deck.into()
    }
}