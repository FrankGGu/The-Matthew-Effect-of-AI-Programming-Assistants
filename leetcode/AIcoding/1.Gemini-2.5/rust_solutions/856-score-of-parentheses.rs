impl Solution {
    pub fn score_of_parentheses(s: String) -> i32 {
        let mut stack: Vec<i32> = vec![0];
        let mut current_score: i32 = 0;

        for c in s.chars() {
            if c == '(' {
                stack.push(current_score);
                current_score = 0;
            } else {
                let last_score = stack.pop().unwrap();
                let val = std::cmp::max(2 * current_score, 1);
                current_score = last_score + val;
            }
        }

        current_score
    }
}