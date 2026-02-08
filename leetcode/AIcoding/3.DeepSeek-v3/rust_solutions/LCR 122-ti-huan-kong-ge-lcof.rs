impl Solution {
    pub fn path_encryption(path: String) -> String {
        path.chars().map(|c| if c == '.' { ' ' } else { c }).collect()
    }
}