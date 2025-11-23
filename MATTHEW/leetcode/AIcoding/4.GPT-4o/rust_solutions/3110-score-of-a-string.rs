impl Solution {
    pub fn score_of_string(s: String) -> i32 {
        let mut score = 0;
        let mut stack = vec![];

        for c in s.chars() {
            if c == '(' {
                stack.push(score);
                score = 0;
            } else {
                score = stack.pop().unwrap_or(0) + (score * 2).max(1);
            }
        }

        score
    }
}