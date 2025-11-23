impl Solution {
    pub fn make_smallest_palindrome(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        for i in 0..n / 2 {
            let j = n - 1 - i;
            if chars[i] != chars[j] {
                if chars[i] < chars[j] {
                    chars[j] = chars[i];
                } else {
                    chars[i] = chars[j];
                }
            }
        }

        chars.into_iter().collect()
    }
}