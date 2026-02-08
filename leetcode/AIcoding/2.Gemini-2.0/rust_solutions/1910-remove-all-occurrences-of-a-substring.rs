impl Solution {
    pub fn remove_occurrences(s: String, part: String) -> String {
        let mut res = s;
        while res.contains(&part) {
            if let Some(index) = res.find(&part) {
                res.replace_range(index..index + part.len(), "");
            } else {
                break;
            }
        }
        res
    }
}