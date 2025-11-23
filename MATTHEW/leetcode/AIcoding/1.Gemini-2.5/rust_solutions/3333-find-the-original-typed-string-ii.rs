impl Solution {
    pub fn is_long_pressed_name(name: String, typed: String) -> bool {
        let name_chars: Vec<char> = name.chars().collect();
        let typed_chars: Vec<char> = typed.chars().collect();

        let mut i = 0; // Pointer for the 'name' string
        let mut j = 0; // Pointer for the 'typed' string

        while j < typed_chars.len() {
            if i < name_chars.len() && name_chars[i] == typed_chars[j] {
                // Current characters match, advance both pointers
                i += 1;
                j += 1;
            } else if j > 0 && typed_chars[j] == typed_chars[j - 1] {
                // Current character in 'typed' is a long press of the previous typed character
                // Only advance the 'typed' pointer
                j += 1;
            } else {
                // Mismatch and not a valid long press, so 'typed' cannot be formed from 'name'
                return false;
            }
        }

        // After iterating through 'typed', all characters in 'name' must have been matched
        i == name_chars.len()
    }
}