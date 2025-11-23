impl Solution {
    pub fn smallest_number(pattern: String) -> String {
        let mut res = Vec::new();
        let mut stack = Vec::new();
        let pattern = pattern.chars().collect::<Vec<_>>();
        for i in 0..=pattern.len() {
            stack.push((b'1' + i as u8) as char);
            if i == pattern.len() || pattern[i] == 'I' {
                while let Some(c) = stack.pop() {
                    res.push(c);
                }
            }
        }
        res.into_iter().collect()
    }
}