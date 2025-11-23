impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn find_min_steps(mut board: String, mut hand: String) -> i32 {
        let mut hand_chars = vec![];
        for c in hand.chars() {
            hand_chars.push(c);
        }
        hand_chars.sort();
        hand = hand_chars.iter().collect();

        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();

        queue.push_back((board.clone(), hand.clone(), 0));
        visited.insert((board.clone(), hand.clone()));

        while let Some((current_board, current_hand, steps)) = queue.pop_front() {
            if current_board.is_empty() {
                return steps;
            }

            let mut next_hand = current_hand.clone();
            next_hand.sort();

            for i in 0..current_hand.len() {
                let c = current_hand.chars().nth(i).unwrap();
                let mut new_hand = current_hand.chars().enumerate().filter(|(idx, _)| *idx != i).map(|(_, ch)| ch).collect::<String>();
                new_hand.sort();

                for j in 0..current_board.len() {
                    let mut new_board = current_board.clone();
                    new_board.insert(j, c);

                    let new_board_str = &new_board;

                    if !visited.contains(&(new_board_str.to_string(), new_hand.clone())) {
                        visited.insert((new_board_str.to_string(), new_hand.clone()));
                        queue.push_back((new_board_str.to_string(), new_hand.clone(), steps + 1));
                    }
                }
            }
        }

        -1
    }
}
}