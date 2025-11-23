struct Solution;

impl Solution {
    pub fn min_length(s: String) -> i32 {
        let mut stack = Vec::new();
        for c in s.chars() {
            if let Some(&last) = stack.last() {
                if (last == 'A' && c == 'B') || (last == 'B' && c == 'A') || (last == 'C' && c == 'D') || (last == 'D' && c == 'C') {
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