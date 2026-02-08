impl Solution {
    pub fn score_of_parentheses(s: String) -> i32 {
        let mut stack: Vec<i32> = Vec::new();
        for c in s.chars() {
            if c == '(' {
                stack.push(0);
            } else {
                let top = stack.pop().unwrap();
                if top == 0 {
                    if stack.is_empty() {
                        stack.push(1);
                    } else {
                        let prev = stack.pop().unwrap();
                        stack.push(prev + 1);
                    }
                } else {
                    if stack.is_empty() {
                        stack.push(2 * top);
                    } else {
                        let prev = stack.pop().unwrap();
                        stack.push(prev + 2 * top);
                    }
                }
            }
        }
        stack[0]
    }
}