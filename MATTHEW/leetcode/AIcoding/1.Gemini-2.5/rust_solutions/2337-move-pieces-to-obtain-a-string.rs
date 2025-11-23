impl Solution {
    pub fn can_change(start: String, target: String) -> bool {
        let n = start.len();
        if n != target.len() {
            return false;
        }

        let start_chars: Vec<char> = start.chars().collect();
        let target_chars: Vec<char> = target.chars().collect();

        let mut i = 0; // pointer for start string
        let mut j = 0; // pointer for target string

        while i < n && j < n {
            // Skip underscores in start
            while i < n && start_chars[i] == '_' {
                i += 1;
            }
            // Skip underscores in target
            while j < n && target_chars[j] == '_' {
                j += 1;
            }

            // If one string ran out of non-underscore characters but the other didn't
            if i == n || j == n {
                break;
            }

            // If characters at current non-underscore positions don't match
            if start_chars[i] != target_chars[j] {
                return false;
            }

            // Check movement rules
            if start_chars[i] == 'L' {
                // 'L' can only move left, so its target index must be <= start index
                if j > i {
                    return false;
                }
            } else { // start_chars[i] == 'R'
                // 'R' can only move right, so its target index must be >= start index
                if j < i {
                    return false;
                }
            }

            i += 1;
            j += 1;
        }

        // After the loop, ensure any remaining characters are only underscores
        while i < n {
            if start_chars[i] != '_' {
                return false;
            }
            i += 1;
        }
        while j < n {
            if target_chars[j] != '_' {
                return false;
            }
            j += 1;
        }

        true
    }
}