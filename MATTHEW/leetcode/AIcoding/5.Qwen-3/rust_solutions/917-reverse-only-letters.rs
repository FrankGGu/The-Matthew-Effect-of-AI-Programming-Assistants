struct Solution;

impl Solution {
    pub fn reverse_only_letters(s: String) -> String {
        let mut chars: Vec<char> = s.chars().filter(|c| c.is_alphabetic()).collect();
        let mut result = String::new();
        let mut i = chars.len() as isize - 1;

        for c in s.chars() {
            if c.is_alphabetic() {
                result.push(chars[i as usize]);
                i -= 1;
            } else {
                result.push(c);
            }
        }

        result
    }
}