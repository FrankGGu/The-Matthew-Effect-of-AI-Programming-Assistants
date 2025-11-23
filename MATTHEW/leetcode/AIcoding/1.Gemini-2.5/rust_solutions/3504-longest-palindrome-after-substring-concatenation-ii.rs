use std::collections::HashMap;

impl Solution {
    pub fn longest_palindrome(words: Vec<String>) -> i32 {
        let mut counts: HashMap<u16, i32> = HashMap::new();

        for word_str in words {
            let bytes = word_str.as_bytes();
            // Convert the two-character word into a u16 for efficient hashing
            // byte1 (MSB) | byte2 (LSB)
            let val = (bytes[0] as u16) << 8 | (bytes[1] as u16);
            *counts.entry(val).or_insert(0) += 1;
        }

        let mut ans = 0;
        let mut has_center = false;

        // Collect keys to iterate over, as we might modify the map during iteration
        let keys: Vec<u16> = counts.keys().cloned().collect();

        for &word_val in &keys {
            // Get the current count for the word_val
            // If the word_val is no longer in the map or its count is 0, skip it
            if let Some(&count) = counts.get(&word_val) {
                if count == 0 {
                    continue;
                }

                let byte1 = (word_val >> 8) as u8;
                let byte2 = (word_val & 0xFF) as u8;

                if byte1 == byte2 { // Palindromic word (e.g., "gg", "aa")
                    // Add pairs of these words to the total length
                    ans += (count / 2) * 4;
                    // If there's an odd count, one word can be used as the center
                    if count % 2 == 1 {
                        has_center = true;
                    }
                    // Mark this word as fully processed
                    counts.insert(word_val, 0);
                } else { // Non-palindromic word (e.g., "lc", "cl")
                    // Construct the reverse word's u16 value
                    let rev_word_val = (byte2 as u16) << 8 | (byte1 as u16);

                    // Check if the reverse word exists in the map
                    if let Some(&rev_count) = counts.get(&rev_word_val) {
                        // The number of pairs we can form is limited by the minimum of their counts
                        let pairs = count.min(rev_count);
                        ans += pairs * 4; // Each pair adds 4 to the length (e.g., "lc" + "cl" = "lccl")

                        // Decrement the counts for both words as they have been used
                        *counts.get_mut(&word_val).unwrap() -= pairs;
                        *counts.get_mut(&rev_word_val).unwrap() -= pairs;
                    }
                }
            }
        }

        // If we found any palindromic word with an odd count, one of them can be placed in the center
        // This adds 2 to the total length (the length of one such word)
        if has_center {
            ans += 2;
        }

        ans
    }
}