impl Solution {
    pub fn remove_trailing_zeros(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        while let Some(&last) = chars.last() {
            if last == '0' {
                chars.pop();
            } else {
                break;
            }
        }
        chars.into_iter().collect()
    }
}