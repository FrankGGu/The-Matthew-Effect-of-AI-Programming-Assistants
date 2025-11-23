impl Solution {
    pub fn remove_trailing_zeros(num: String) -> String {
        let mut end_idx = num.len();
        for (i, c) in num.chars().rev().enumerate() {
            if c != '0' {
                end_idx = num.len() - i;
                break;
            }
        }
        num[0..end_idx].to_string()
    }
}