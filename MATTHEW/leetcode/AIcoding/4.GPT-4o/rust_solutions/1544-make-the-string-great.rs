impl Solution {
    pub fn make_good(s: String) -> String {
        let mut stack = Vec::new();
        for c in s.chars() {
            if let Some(&top) = stack.last() {
                if (c.is_ascii_lowercase() && top == c.to_ascii_uppercase()) || 
                   (c.is_ascii_uppercase() && top == c.to_ascii_lowercase()) {
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