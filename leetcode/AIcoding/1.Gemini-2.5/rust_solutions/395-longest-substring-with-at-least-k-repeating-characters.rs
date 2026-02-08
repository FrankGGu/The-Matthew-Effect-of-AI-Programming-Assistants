impl Solution {
    pub fn longest_substring(s: String, k: i32) -> i32 {
        Self::longest_substring_recursive(s.as_bytes(), k)
    }

    fn longest_substring_recursive(s_bytes: &[u8], k: i32) -> i32 {
        let n = s_bytes.len();
        if n == 0 || n < k as usize {
            return 0;
        }

        let mut counts = [0; 26];
        for &c in s_bytes {
            counts[(c - b'a') as usize] += 1;
        }

        // Find if there's any character that appears less than k times in the current segment.
        // If not, the entire segment is a valid substring.
        let mut needs_split = false;
        for &count in counts.iter() {
            if count > 0 && count < k {
                needs_split = true;
                break;
            }
        }

        if !needs_split {
            return n as i32;
        }

        let mut max_len = 0;
        let mut current_start = 0;
        for i in 0..n {
            let char_idx = (s_bytes[i] - b'a') as usize;
            if counts[char_idx] < k {
                // This character is a split point.
                // Recursively check the segment before this split point.
                if i > current_start {
                    max_len = max_len.max(Self::longest_substring_recursive(&s_bytes[current_start..i], k));
                }
                // Move the start of the next segment past this split character.
                current_start = i + 1;
            }
        }

        // After the loop, process the last segment if it exists.
        if current_start < n {
            max_len = max_len.max(Self::longest_substring_recursive(&s_bytes[current_start..n], k));
        }

        max_len
    }
}