impl Solution {
    pub fn split_strings_by_separator(s: String, separator: char) -> Vec<String> {
        s.split(separator).map(|s| s.to_string()).collect()
    }
}