use std::collections::HashMap;

impl Solution {
    pub fn can_win(s: String) -> bool {
        let mut memo: HashMap<String, bool> = HashMap::new();
        Self::can_win_memo(&mut memo, &s)
    }

    fn can_win_memo(memo: &mut HashMap<String, bool>, s_ref: &str) -> bool {
        if let Some(&result) = memo.get(s_ref) {
            return result;
        }

        let n = s_ref.len();
        let mut chars: Vec<char> = s_ref.chars().collect();

        for i in 0..n - 1 {
            if chars[i] == '+' && chars[i + 1] == '+' {
                // Make a move: flip "++" to "--"
                chars[i] = '-';
                chars[i + 1] = '-';

                let next_s: String = chars.iter().collect();

                // If the opponent CANNOT win from this new state, then the current player WINS
                if !Self::can_win_memo(memo, &next_s) {
                    memo.insert(s_ref.to_string(), true);
                    return true;
                }

                // Backtrack: undo the move for the next iteration
                chars[i] = '+';
                chars[i + 1] = '+';
            }
        }

        // If no move leads to a win, the current player loses
        memo.insert(s_ref.to_string(), false);
        false
    }
}