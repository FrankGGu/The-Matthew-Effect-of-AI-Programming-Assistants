impl Solution {
    pub fn number_of_changing_keys(s: String) -> i32 {
        let s = s.to_lowercase();
        let chars: Vec<char> = s.chars().collect();
        let mut count = 0;
        for i in 1..chars.len() {
            if chars[i] != chars[i - 1] {
                count += 1;
            }
        }
        count
    }
}