use std::collections::HashMap;

impl Solution {
    pub fn find_min_step(board: String, hand: String) -> i32 {
        let mut hand_map: HashMap<char, i32> = HashMap::new();
        for c in hand.chars() {
            *hand_map.entry(c).or_insert(0) += 1;
        }

        let mut queue = std::collections::VecDeque::new();
        queue.push((board, hand_map, 0));

        let mut visited = std::collections::HashSet::new();
        visited.insert(board.clone());

        while let Some((curr_board, curr_hand, steps)) = queue.pop_front() {
            if curr_board.is_empty() {
                return steps;
            }

            for i in 0..=curr_board.len() {
                for (&color, &count) in &curr_hand {
                    if count > 0 {
                        let mut next_board = curr_board.clone();
                        next_board.insert(i, color);
                        let next_board = Self::eliminate(next_board);

                        let mut next_hand = curr_hand.clone();
                        *next_hand.get_mut(&color).unwrap() -= 1;

                        if !visited.contains(&next_board) {
                            visited.insert(next_board.clone());
                            queue.push((next_board, next_hand, steps + 1));
                        }
                    }
                }
            }
        }

        -1
    }

    fn eliminate(board: String) -> String {
        let mut res = board;
        let mut changed = true;

        while changed {
            changed = false;
            let mut i = 0;
            while i < res.len() {
                let mut j = i;
                while j < res.len() && res.chars().nth(i) == res.chars().nth(j) {
                    j += 1;
                }
                if j - i >= 3 {
                    res.replace_range(i..j, "");
                    changed = true;
                    break;
                }
                i = j;
            }
        }

        res
    }
}