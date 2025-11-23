impl Solution {
    pub fn is_long_pressed_name(name: String, typed: String) -> bool {
        let name_chars: Vec<char> = name.chars().collect();
        let typed_chars: Vec<char> = typed.chars().collect();

        let mut i = 0; // Pointer for name
        let mut j = 0; // Pointer for typed

        while j < typed_chars.len() {
            if i < name_chars.len() && name_chars[i] == typed_chars[j] {
                // Character matches, advance both pointers
                i += 1;
                j += 1;
            } else if j > 0 && typed_chars[j] == typed_chars[j - 1] {
                // Character is a long-press of the previous character in typed
                j += 1;
            } else {
                // Mismatch: current typed character is neither a match for name
                // nor a valid long-press
                return false;
            }
        }

        // After iterating through all characters in typed,
        // all characters in name must have been matched.
        i == name_chars.len()
    }
}