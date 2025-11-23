impl Solution {
    pub fn is_valid(s: String) -> bool {
        let mut stack = Vec::new();
        for c in s.chars() {
            if c == 'c' {
                if stack.len() >= 2 && stack[stack.len() - 1] == 'b' && stack[stack.len() - 2] == 'a' {
                    stack.pop();
                    stack.pop();
                } else {
                    return false;
                }
            } else {
                stack.push(c);
            }
        }
        stack.is_empty()
    }
}