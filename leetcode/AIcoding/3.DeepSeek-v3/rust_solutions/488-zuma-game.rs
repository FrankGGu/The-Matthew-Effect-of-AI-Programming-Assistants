impl Solution {
    pub fn find_min_step(board: String, hand: String) -> i32 {
        use std::collections::HashMap;

        fn dfs(board: &[u8], hand: &mut HashMap<u8, i32>, memo: &mut HashMap<String, i32>) -> i32 {
            if board.is_empty() {
                return 0;
            }
            let key = format!("{}_{:?}", String::from_utf8_lossy(board), hand);
            if let Some(&res) = memo.get(&key) {
                return res;
            }
            let mut res = i32::MAX;
            let mut i = 0;
            while i < board.len() {
                let j = i;
                while j < board.len() && board[j] == board[i] {
                    j += 1;
                }
                let color = board[i];
                let need = 3 - (j - i) as i32;
                if hand.get(&color).unwrap_or(&0) >= &need {
                    let mut new_hand = hand.clone();
                    *new_hand.get_mut(&color).unwrap() -= need;
                    if new_hand[&color] == 0 {
                        new_hand.remove(&color);
                    }
                    let mut new_board = board[..i].to_vec();
                    new_board.extend_from_slice(&board[j..]);
                    let next = dfs(&Self::simplify(&new_board), &mut new_hand, memo);
                    if next != -1 {
                        res = res.min(need + next);
                    }
                }
                i = j;
            }
            if res == i32::MAX {
                memo.insert(key, -1);
                -1
            } else {
                memo.insert(key, res);
                res
            }
        }

        let mut hand_map = HashMap::new();
        for c in hand.bytes() {
            *hand_map.entry(c).or_insert(0) += 1;
        }
        let mut memo = HashMap::new();
        dfs(board.as_bytes(), &mut hand_map, &mut memo)
    }

    fn simplify(board: &[u8]) -> Vec<u8> {
        let mut stack = Vec::new();
        for &color in board {
            stack.push(color);
            while stack.len() >= 3 {
                let n = stack.len();
                if stack[n - 1] == stack[n - 2] && stack[n - 2] == stack[n - 3] {
                    let color = stack[n - 1];
                    while !stack.is_empty() && *stack.last().unwrap() == color {
                        stack.pop();
                    }
                } else {
                    break;
                }
            }
        }
        stack
    }
}