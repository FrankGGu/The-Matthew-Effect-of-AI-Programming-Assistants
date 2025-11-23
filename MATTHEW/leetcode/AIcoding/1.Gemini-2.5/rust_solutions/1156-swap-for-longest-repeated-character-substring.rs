use std::cmp::max;

impl Solution {
    pub fn max_rep_opt1(text: String) -> i32 {
        let n = text.len();
        if n == 0 {
            return 0;
        }

        let chars: Vec<char> = text.chars().collect();
        let mut counts: [usize; 26] = [0; 26];
        for &c in chars.iter() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut blocks: Vec<(char, usize)> = Vec::new();
        let mut i = 0;
        while i < n {
            let current_char = chars[i];
            let mut j = i;
            while j < n && chars[j] == current_char {
                j += 1;
            }
            blocks.push((current_char, j - i));
            i = j;
        }

        let mut max_len = 0;

        // Case 1: Consider each block individually.
        // Try to extend it by one character using a swap.
        // For example, "aaabbb" could become "aaaabb" if there's another 'a' available.
        for &(c, len) in blocks.iter() {
            let char_idx = (c as u8 - b'a') as usize;
            // If the total count of character 'c' in the string is greater than the current block's length,
            // it means there's at least one 'c' available outside this block.
            // We can swap a character adjacent to this block with that external 'c' to extend the block by 1.
            // The maximum possible length would be `len + 1`, but it cannot exceed the total count of 'c's.
            max_len = max(max_len, len + (if counts[char_idx] > len { 1 } else { 0 }));
        }

        // Case 2: Consider merging two blocks of the same character separated by exactly one different character.
        // For example, "aaabaaa" could become "aaaaaaa" by swapping 'b' with an 'a'.
        // If, after merging, there's still an 'a' available elsewhere, we can extend it by one more.
        for i in 0..blocks.len() {
            if i + 2 < blocks.len() { // Ensure there are at least 3 blocks to consider: blocks[i], blocks[i+1], blocks[i+2]
                let (c1, len1) = blocks[i];
                let (_c_mid, len_mid) = blocks[i+1]; // The character of the middle block is not needed, only its length
                let (c2, len2) = blocks[i+2];

                // Check if two blocks of the same character are separated by exactly one character
                if c1 == c2 && len_mid == 1 {
                    let char_idx = (c1 as u8 - b'a') as usize;
                    let current_merged_len = len1 + len2;
                    // If the total count of character 'c1' is greater than the combined length of the two blocks,
                    // it means there's an extra 'c1' available. We can use it to extend the merged block by 1.
                    // The maximum possible length would be `current_merged_len + 1`, but it cannot exceed the total count of 'c1's.
                    max_len = max(max_len, current_merged_len + (if counts[char_idx] > current_merged_len { 1 } else { 0 }));
                }
            }
        }

        max_len as i32
    }
}