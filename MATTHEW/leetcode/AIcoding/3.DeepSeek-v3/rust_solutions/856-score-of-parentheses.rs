impl Solution {
    pub fn score_of_parentheses(s: String) -> i32 {
        let mut stack = vec![0];
        for c in s.chars() {
            if c == '(' {
                stack.push(0);
            } else {
                let top = stack.pop().unwrap();
                let new_top = stack.pop().unwrap() + if top == 0 { 1 } else { 2 * top };
                stack.push(new_top);
            }
        }
        stack.pop().unwrap()
    }
}