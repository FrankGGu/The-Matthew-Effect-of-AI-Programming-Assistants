impl Solution {
    pub fn is_long_pressed_name(name: String, typed: String) -> bool {
        let n_chars: Vec<char> = name.chars().collect();
        let t_chars: Vec<char> = typed.chars().collect();

        let mut i = 0; // Pointer for the 'name' string
        let mut j = 0; // Pointer for the 'typed' string

        while j < t_chars.len() {
            if i < n_chars.len() && n_chars[i] == t_chars[j] {
                // Current characters match, advance both pointers
                i += 1;
                j += 1;
            } else if j > 0 && t_chars[j] == t_chars[j - 1] {
                // Current character in 'typed' is a long press of the previous character in 'typed'
                j += 1;
            } else {
                // Mismatch and not a valid long press sequence, so 'typed' cannot be formed from 'name'
                return false;
            }
        }

        // After iterating through 'typed', all characters in 'name' must have been matched
        i == n_chars.len()
    }
}