impl Solution {
    pub fn lexicographically_smallest_string(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        let mut start_idx = 0;
        while start_idx < n && chars[start_idx] == 'a' {
            start_idx += 1;
        }

        if start_idx == n {
            // All characters are 'a'. We must perform an operation.
            // To get the lexicographically smallest result, change the last 'a' to 'z'.
            // For example, "aaa" -> "aaz" is smaller than "aza" or "zaa".
            if n > 0 { // Ensure the string is not empty
                chars[n - 1] = 'z';
            }
        } else {
            // Found the first non-'a' character at start_idx.
            // We want to decrement this character and subsequent characters
            // as long as they are not 'a'.
            let mut current_idx = start_idx;
            while current_idx < n && chars[current_idx] != 'a' {
                chars[current_idx] = (chars[current_idx] as u8 - 1) as char;
                current_idx += 1;
            }
        }

        chars.into_iter().collect()
    }
}