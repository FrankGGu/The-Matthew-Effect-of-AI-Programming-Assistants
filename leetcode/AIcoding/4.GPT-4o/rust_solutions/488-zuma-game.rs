impl Solution {
    pub fn find_min_step(board: String, hand: String) -> i32 {
        let mut hand_counts = [0; 26];
        for c in hand.chars() {
            hand_counts[c as usize - 'A' as usize] += 1;
        }

        fn remove_balls(board: &str) -> String {
            let mut stack = vec![];
            for c in board.chars() {
                if let Some(&last) = stack.last() {
                    if last == c {
                        stack.push(c);
                    } else {
                        if stack.len() >= 2 && stack.len() > 0 {
                            stack.pop();
                        } else {
                            stack.push(c);
                        }
                    }
                } else {
                    stack.push(c);
                }
            }
            stack.into_iter().collect()
        }

        fn dfs(board: String, hand_counts: &mut [i32; 26]) -> i32 {
            let board = remove_balls(&board);
            if board.is_empty() {
                return 0;
            }
            let mut res = i32::MAX;
            let mut i = 0;
            while i < board.len() {
                let mut j = i;
                while j < board.len() && board.chars().nth(j) == board.chars().nth(i) {
                    j += 1;
                }
                let needed = 3 - (j - i) as i32;
                if needed > 0 && hand_counts[board.chars().nth(i) as usize - 'A' as usize] >= needed {
                    hand_counts[board.chars().nth(i) as usize - 'A' as usize] -= needed;
                    let next_res = dfs(board[..i].to_string() + &board[j..].to_string(), hand_counts);
                    if next_res != -1 {
                        res = res.min(next_res + needed);
                    }
                    hand_counts[board.chars().nth(i) as usize - 'A' as usize] += needed;
                }
                i = j;
            }
            if res == i32::MAX {
                -1
            } else {
                res
            }
        }

        let result = dfs(board, &mut hand_counts);
        if result == i32::MAX {
            -1
        } else {
            result
        }
    }
}