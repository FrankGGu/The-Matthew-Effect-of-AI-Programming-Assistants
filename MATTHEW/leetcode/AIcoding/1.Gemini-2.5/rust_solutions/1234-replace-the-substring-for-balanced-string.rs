impl Solution {
    pub fn balanced_string(s: String) -> i32 {
        let n = s.len();
        let k = (n / 4) as i32;

        let mut total_freq = [0; 4]; // Q, W, E, R
        let s_chars: Vec<char> = s.chars().collect();

        // Helper to map char to index
        let char_to_idx = |c: char| -> usize {
            match c {
                'Q' => 0,
                'W' => 1,
                'E' => 2,
                'R' => 3,
                _ => unreachable!(),
            }
        };

        // Calculate total frequencies of characters in the entire string
        for &c in &s_chars {
            total_freq[char_to_idx(c)] += 1;
        }

        // Calculate the 'needed' counts: how many of each character must be
        // present *within* the replacement window to balance the string.
        // This is equivalent to how many characters are in excess in the
        // *total* string that need to be "removed" (changed) by the window.
        let mut needed = [0; 4];
        let mut is_already_balanced = true;
        for i in 0..4 {
            if total_freq[i] > k {
                needed[i] = total_freq[i] - k;
                is_already_balanced = false;
            }
        }

        // If the string is already balanced, no replacement is needed.
        if is_already_balanced {
            return 0;
        }

        let mut current_window_counts = [0; 4];
        let mut left = 0;
        let mut min_len = n as i32;

        // Helper to check if the current window contains enough of the
        // 'needed' characters to balance the string.
        // This means for each char 'c', current_window_counts[c] >= needed[c].
        let check_condition = |window_counts: &[i32; 4], required_counts: &[i32; 4]| -> bool {
            for i in 0..4 {
                if window_counts[i] < required_counts[i] {
                    return false;
                }
            }
            true
        };

        // Sliding window approach
        // 'right' expands the window, 'left' shrinks it.
        for right in 0..n {
            let right_char_idx = char_to_idx(s_chars[right]);
            current_window_counts[right_char_idx] += 1;

            // While the current window satisfies the condition (i.e., it contains
            // all the characters that are in excess in the total string),
            // try to shrink the window from the left to find the minimum length.
            while check_condition(&current_window_counts, &needed) {
                min_len = min_len.min((right - left + 1) as i32);

                let left_char_idx = char_to_idx(s_chars[left]);
                current_window_counts[left_char_idx] -= 1;
                left += 1;
            }
        }

        min_len
    }
}