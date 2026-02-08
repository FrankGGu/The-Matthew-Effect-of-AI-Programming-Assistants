struct Solution;

impl Solution {
    pub fn is_valid(s: String) -> bool {
        let mut stack: Vec<char> = Vec::new();

        for c in s.chars() {
            match c {
                '(' | '[' | '{' => {
                    stack.push(c);
                }
                ')' => {
                    if stack.pop() != Some('(') {
                        return false;
                    }
                }
                ']' => {
                    if stack.pop() != Some('[') {
                        return false;
                    }
                }
                '}' => {
                    if stack.pop() != Some('{') {
                        return false;
                    }
                }
                _ => {
                    // According to LeetCode problem 20 "Valid Parentheses",
                    // the input string consists only of '(', ')', '{', '}', '[', ']'.
                    // Therefore, this branch should not be reachable with valid inputs.
                }
            }
        }

        stack.is_empty()
    }
}