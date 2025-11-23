impl Solution {
    pub fn remove_occurrences(mut s: String, part: String) -> String {
        loop {
            if let Some(idx) = s.find(&part) {
                s.replace_range(idx..idx + part.len(), "");
            } else {
                break;
            }
        }
        s
    }
}