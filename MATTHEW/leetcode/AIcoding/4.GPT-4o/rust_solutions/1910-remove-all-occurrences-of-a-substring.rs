impl Solution {
    pub fn remove_occurrences(s: String, part: String) -> String {
        let mut result = s;
        while let Some(pos) = result.find(&part) {
            result.replace_range(pos..pos + part.len(), "");
        }
        result
    }
}