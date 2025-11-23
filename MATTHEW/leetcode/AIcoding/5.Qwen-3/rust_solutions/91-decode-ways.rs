impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_decodings(s: String) -> i32 {
        let mut memo = HashMap::new();
        Self::dfs(&s, 0, &mut memo)
    }

    fn dfs(s: &str, index: usize, memo: &mut HashMap<usize, i32>) -> i32 {
        if index == s.len() {
            return 1;
        }
        if let Some(&count) = memo.get(&index) {
            return count;
        }

        let mut count = 0;
        if let Some(digit) = s.chars().nth(index).and_then(|c| c.to_digit(10)) {
            if digit != 0 {
                count += Self::dfs(s, index + 1, memo);
            }
        }

        if index + 1 < s.len() {
            if let Some(first) = s.chars().nth(index).and_then(|c| c.to_digit(10)) {
                if first != 0 {
                    if let Some(second) = s.chars().nth(index + 1).and_then(|c| c.to_digit(10)) {
                        let two_digit = first * 10 + second;
                        if two_digit <= 26 {
                            count += Self::dfs(s, index + 2, memo);
                        }
                    }
                }
            }
        }

        memo.insert(index, count);
        count
    }
}
}