impl Solution {
    pub fn make_smallest_palindrome(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        for i in 0..n / 2 {
            let j = n - 1 - i;
            if chars[i] != chars[j] {
                let min_char = std::cmp::min(chars[i], chars[j]);
                chars[i] = min_char;
                chars[j] = min_char;
            }
        }
        chars.into_iter().collect()
    }
}