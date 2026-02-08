impl Solution {
    pub fn score_of_parentheses(s: String) -> i32 {
        let mut score = 0;
        let mut depth = 0;

        for c in s.chars() {
            if c == '(' {
                depth += 1;
            } else {
                depth -= 1;
                if s.chars().nth(s.len() - depth - 1) == Some('(') {
                    score += 1 << depth;
                }
            }
        }
        score
    }
}