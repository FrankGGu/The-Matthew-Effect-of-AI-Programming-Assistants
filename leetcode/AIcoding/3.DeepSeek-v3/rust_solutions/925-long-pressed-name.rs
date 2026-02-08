impl Solution {
    pub fn is_long_pressed_name(name: String, typed: String) -> bool {
        let name_chars: Vec<char> = name.chars().collect();
        let typed_chars: Vec<char> = typed.chars().collect();
        let (n, m) = (name_chars.len(), typed_chars.len());
        let (mut i, mut j) = (0, 0);

        while j < m {
            if i < n && name_chars[i] == typed_chars[j] {
                i += 1;
                j += 1;
            } else if j > 0 && typed_chars[j] == typed_chars[j - 1] {
                j += 1;
            } else {
                return false;
            }
        }

        i == n
    }
}