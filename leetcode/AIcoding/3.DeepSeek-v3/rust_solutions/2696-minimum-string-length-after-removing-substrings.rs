impl Solution {
    pub fn min_length(s: String) -> i32 {
        let mut stack: Vec<char> = Vec::new();
        for c in s.chars() {
            if !stack.is_empty() {
                let last = *stack.last().unwrap();
                if (last == 'A' && c == 'B') || (last == 'C' && c == 'D') {
                    stack.pop();
                    continue;
                }
            }
            stack.push(c);
        }
        stack.len() as i32
    }
}