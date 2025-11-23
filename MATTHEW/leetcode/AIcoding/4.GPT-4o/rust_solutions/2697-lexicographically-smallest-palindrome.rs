impl Solution {
    pub fn make_smallest_palindrome(s: String) -> String {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let mut result = chars.clone();

        for i in 0..(n / 2) {
            result[i] = result[n - 1 - i] = std::cmp::min(chars[i], chars[n - 1 - i]);
        }

        result.iter().collect()
    }
}