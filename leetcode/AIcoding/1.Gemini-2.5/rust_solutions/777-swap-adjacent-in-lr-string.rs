impl Solution {
    pub fn can_transform(start: String, end: String) -> bool {
        if start.len() != end.len() {
            return false;
        }

        let n = start.len();
        let s_chars: Vec<char> = start.chars().collect();
        let e_chars: Vec<char> = end.chars().collect();

        let mut i = 0; // Pointer for start string
        let mut j = 0; // Pointer for end string

        loop {
            // Advance i past 'X's in start
            while i < n && s_chars[i] == 'X' {
                i += 1;
            }
            // Advance j past 'X's in end
            while j < n && e_chars[j] == 'X' {
                j += 1;
            }

            // If both pointers reached the end, all non-'X' characters matched and satisfied conditions
            if i == n && j == n {
                return true;
            }
            // If one pointer reached the end but the other didn't,
            // it means the sequence of non-'X' characters is different.
            if i == n || j == n {
                return false;
            }

            // Now s_chars[i] and e_chars[j] are guaranteed to be non-'X' characters.
            // They must be the same character.
            if s_chars[i] != e_chars[j] {
                return false;
            }

            // Check movement rules
            if s_chars[i] == 'L' {
                // 'L' can only move left (or stay in place).
                // So, its starting index i must be greater than or equal to its ending index j.
                if i < j {
                    return false; // 'L' moved right, which is forbidden.
                }
            } else { // s_chars[i] == 'R'
                // 'R' can only move right (or stay in place).
                // So, its starting index i must be less than or equal to its ending index j.
                if i > j {
                    return false; // 'R' moved left, which is forbidden.
                }
            }

            // Move to the next non-'X' character pair
            i += 1;
            j += 1;
        }
    }
}