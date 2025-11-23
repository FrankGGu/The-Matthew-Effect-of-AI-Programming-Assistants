impl Solution {
    pub fn make_smallest_palindrome(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        for i in 0..(n / 2) {
            if chars[i] != chars[n - 1 - i] {
                if chars[i] < chars[n - 1 - i] {
                    chars[n - 1 - i] = chars[i];
                } else {
                    chars[i] = chars[n - 1 - i];
                }
            }
        }

        chars.into_iter().collect()
    }
}