use std::collections::HashMap;

struct Solution;

impl Solution {
    fn char_to_idx(c: char) -> usize {
        match c {
            'R' => 0,
            'Y' => 1,
            'B' => 2,
            'G' => 3,
            'W' => 4,
            _ => panic!("Invalid char"),
        }
    }

    fn idx_to_char(idx: usize) -> char {
        match idx {
            0 => 'R',
            1 => 'Y',
            2 => 'B',
            3 => 'G',
            4 => 'W',
            _ => panic!("Invalid idx"),
        }
    }

    fn reduce(mut s: String) -> String {
        loop {
            let mut new_s = String::new();
            let s_chars: Vec<char> = s.chars().collect();
            let n = s_chars.len();
            let mut i = 0;
            let mut reduced_in_this_pass = false;

            while i < n {
                let current_char = s_chars[i];
                let mut j = i;
                while j < n && s_chars[j] == current_char {
                    j += 1;
                }
                let count = j - i;
                if count < 3 {
                    for k in i..j {
                        new_s.push(s_chars[k]);
                    }
                } else {
                    reduced_in_this_pass = true;
                }
                i = j;
            }

            if !reduced_in_this_pass {
                break;
            }
            s = new_s;
        }
        s
    }

    fn solve(
        board: String,
        hand_counts: &mut [i32; 5],
        memo: &mut HashMap<(String, [i32; 5]), i32>,
    ) -> i32 {
        if board.is_empty() {
            return 0;
        }

        let current_state = (board.clone(), *hand_counts);
        if let Some(&res) = memo.get(&current_state) {
            return res;
        }

        let mut min_balls = i32::MAX;
        let board_chars: Vec<char> = board.chars().collect();

        for i in 0..=board_chars.len() {
            for ball_idx in 0..5 {
                if hand_counts[ball_idx] > 0 {
                    let ball_char = Self::idx_to_char(ball_idx);

                    let mut temp_board_chars = board_chars.clone();
                    temp_board_chars.insert(i, ball_char);
                    let new_board_str = temp_board_chars.into_iter().collect::<String>();

                    let reduced_board = Self::reduce(new_board_str);

                    hand_counts[ball_idx] -= 1;
                    let res = Self::solve(reduced_board, hand_counts, memo);
                    hand_counts[ball_idx] += 1;

                    if res != i32::MAX {
                        min_balls = min_balls.min(res + 1);
                    }
                }
            }
        }

        memo.insert(current_state, min_balls);
        min_balls
    }

    pub fn find_min_step(board: String, hand: String) -> i32 {
        let mut hand_counts = [0; 5];
        for c in hand.chars() {
            hand_counts[Self::char_to_idx(c)] += 1;
        }

        let mut memo = HashMap::new();
        let result = Self::solve(board, &mut hand_counts, &mut memo);

        if result == i32::MAX {
            -1
        } else {
            result
        }
    }
}