impl Solution {
    pub fn make_good(s: String) -> String {
        let mut stack: Vec<char> = Vec::new();

        for c in s.chars() {
            if let Some(&last_char) = stack.last() {
                if last_char.to_ascii_lowercase() == c.to_ascii_lowercase() && last_char != c {
                    stack.pop();
                } else {
                    stack.push(c);
                }
            } else {
                stack.push(c);
            }
        }

        stack.into_iter().collect()
    }
}