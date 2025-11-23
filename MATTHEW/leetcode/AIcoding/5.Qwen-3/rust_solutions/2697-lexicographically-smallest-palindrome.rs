struct Solution;

impl Solution {
    pub fn make_smallest_palindrome(mut s: String) -> String {
        let mut chars = s.chars().collect::<Vec<char>>();
        let n = chars.len();
        for i in 0..n / 2 {
            let j = n - 1 - i;
            if chars[i] != chars[j] {
                chars[i] = chars[i].min(chars[j]);
                chars[j] = chars[i];
            }
        }
        chars.into_iter().collect()
    }
}