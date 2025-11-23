impl Solution {
    pub fn make_good(s: String) -> String {
        let mut stack: Vec<char> = Vec::new();
        for c in s.chars() {
            if let Some(&top) = stack.last() {
                if (c.is_lowercase() && top.is_uppercase() && c.to_uppercase().next().unwrap() == top) ||
                   (c.is_uppercase() && top.is_lowercase() && c.to_lowercase().next().unwrap() == top) {
                    stack.pop();
                } else {
                    stack.push(c);
                }
            } else {
                stack.push(c);
            }
        }
        stack.iter().collect()
    }
}