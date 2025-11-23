impl Solution {
    pub fn make_good(s: String) -> String {
        let mut stack = Vec::new();
        for c in s.chars() {
            if let Some(&last) = stack.last() {
                if last != c && last.eq_ignore_ascii_case(&c) {
                    stack.pop();
                    continue;
                }
            }
            stack.push(c);
        }
        stack.into_iter().collect()
    }
}