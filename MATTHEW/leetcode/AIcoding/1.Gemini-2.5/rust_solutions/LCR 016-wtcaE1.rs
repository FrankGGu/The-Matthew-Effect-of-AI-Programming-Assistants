struct Solution;

impl Solution {
    pub fn length_of_longest_substring(s: String) -> i32 {
        let mut max_len = 0;
        let mut left = 0;
        // `char_map` stores the last seen index of each character.
        // Initialized to -1 to indicate not seen.
        // Assuming ASCII characters (0-127).
        let mut char_map = [-1; 128]; 

        let chars: Vec<char> = s.chars().collect();

        for right in 0..chars.len() {
            let c_code = chars[right] as usize;

            // If the character `chars[right]` was seen before AND its last seen index
            // is within the current window `[left, right-1]`, then we have a duplicate.
            if char_map[c_code] != -1 && char_map[c_code] >= left as i32 {
                // Move the `left` pointer to the position after the last occurrence
                // of the duplicate character to ensure the window has no repeating characters.
                left = (char_map[c_code] + 1) as usize;
            }

            // Update the last seen index of the current character `chars[right]`.
            char_map[c_code] = right as i32;

            // Calculate the length of the current window `[left, right]` and update `max_len`.
            max_len = max_len.max((right - left + 1) as i32);
        }

        max_len
    }
}