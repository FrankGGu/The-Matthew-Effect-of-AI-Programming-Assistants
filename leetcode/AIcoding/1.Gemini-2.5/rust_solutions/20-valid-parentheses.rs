impl Solution {
    pub fn is_valid(s: String) -> bool {
        let mut stack: Vec<char> = Vec::new();

        for c in s.chars() {
            match c {
                '(' | '{' | '[' => {
                    stack.push(c);
                }
                ')' => {
                    if stack.pop() != Some('(') {
                        return false;
                    }
                }
                '}' => {
                    if stack.pop() != Some('{') {
                        return false;
                    }
                }
                ']' => {
                    if stack.pop() != Some('[') {
                        return false;
                    }
                }
                _ => {
                    // According to problem constraints, input string consists only of '(', ')', '{', '}', '[', ']'.
                    // No other characters are expected.
                }
            }
        }

        stack.is_empty()
    }
}