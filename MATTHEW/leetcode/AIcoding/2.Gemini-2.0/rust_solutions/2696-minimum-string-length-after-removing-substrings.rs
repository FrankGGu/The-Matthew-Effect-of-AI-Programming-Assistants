impl Solution {
    pub fn min_length(s: String) -> i32 {
        let mut stack: Vec<char> = Vec::new();
        for c in s.chars() {
            if !stack.is_empty() {
                let top = stack.last().unwrap();
                if (c == 'B' && *top == 'A') || (c == 'D' && *top == 'C') {
                    stack.pop();
                } else {
                    stack.push(c);
                }
            } else {
                stack.push(c);
            }
        }
        stack.len() as i32
    }
}