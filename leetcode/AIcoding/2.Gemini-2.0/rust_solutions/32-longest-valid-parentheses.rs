impl Solution {
    pub fn longest_valid_parentheses(s: String) -> i32 {
        let mut max_len = 0;
        let mut stack: Vec<i32> = Vec::new();
        stack.push(-1);

        for (i, c) in s.chars().enumerate() {
            if c == '(' {
                stack.push(i as i32);
            } else {
                stack.pop();
                if stack.is_empty() {
                    stack.push(i as i32);
                } else {
                    max_len = max_len.max((i as i32 - *stack.last().unwrap()) as i32);
                }
            }
        }

        max_len
    }
}