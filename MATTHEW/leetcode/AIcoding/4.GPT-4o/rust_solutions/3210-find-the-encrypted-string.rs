impl Solution {
    pub fn find_encrypted_string(s: String) -> String {
        let mut result = String::new();
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        while n > 0 {
            let idx = n / 2;
            result.push(chars.remove(idx));
            chars.rotate_left(idx);
        }

        result
    }
}