impl Solution {
    pub fn find_valid_pair_of_adjacent_digits_in_string(s: String) -> bool {
        let chars: Vec<char> = s.chars().collect();
        if chars.len() < 2 {
            return false;
        }

        for i in 0..chars.len() - 1 {
            if chars[i] == chars[i + 1] && chars[i].is_ascii_digit() {
                return true;
            }
        }
        false
    }
}