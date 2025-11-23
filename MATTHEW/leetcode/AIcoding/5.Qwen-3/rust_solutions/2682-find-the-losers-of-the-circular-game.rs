impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn circular_game_losers(n: i32) -> Vec<i32> {
        let n = n as usize;
        let mut players = VecDeque::from(vec![1; n]);
        let mut current = 0;

        while players.len() > 1 {
            let next = (current + 1) % n;
            players.remove(next);
            current = next;
        }

        players.into_iter().map(|x| x as i32).collect()
    }
}

struct Solution {}
}