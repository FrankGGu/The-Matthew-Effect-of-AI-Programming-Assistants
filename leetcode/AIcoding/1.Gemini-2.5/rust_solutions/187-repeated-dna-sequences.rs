use std::collections::HashMap;

impl Solution {
    pub fn find_repeated_dna_sequences(s: String) -> Vec<String> {
        if s.len() < 10 {
            return Vec::new();
        }

        // Map characters to 2-bit integers for efficient hashing
        // 'A' -> 00 (0)
        // 'C' -> 01 (1)
        // 'G' -> 10 (2)
        // 'T' -> 11 (3)
        let mut char_to_int_map: [u8; 256] = [0; 256];
        char_to_int_map['A' as usize] = 0;
        char_to_int_map['C' as usize] = 1;
        char_to_int_map['G' as usize] = 2;
        char_to_int_map['T' as usize] = 3;

        let s_bytes = s.as_bytes();
        let mut seen_hashes: HashMap<u32, i32> = HashMap::new();
        let mut result: Vec<String> = Vec::new();
        let mut current_hash: u32 = 0;

        // Mask to keep only the last 20 bits, representing 10 characters (10 * 2 bits/char).
        // 0xFFFFF is 20 bits all set to 1.
        let mask: u32 = (1 << 20) - 1;

        for i in 0..s_bytes.len() {
            // Shift the current hash left by 2 bits to make space for the new character's bits.
            // Then, add the 2-bit representation of the current character.
            current_hash = (current_hash << 2) | (char_to_int_map[s_bytes[i] as usize] as u32);

            // Once we have processed at least 10 characters (i.e., i >= 9),
            // `current_hash` represents a 10-character sequence in the sliding window.
            if i >= 9 {
                // Apply the mask to ensure `current_hash` only contains the bits for the
                // most recent 10 characters. This effectively discards the bits of the
                // character that has fallen out of the 10-char window.
                current_hash &= mask;

                // Increment the count for this specific 10-character sequence hash.
                let count = seen_hashes.entry(current_hash).or_insert(0);
                *count += 1;

                // If the count becomes 2, it means this sequence has been seen twice (it's repeated).
                // Add it to the result vector. We only add it when count becomes 2 to avoid duplicates
                // in the result if a sequence appears more than twice.
                if *count == 2 {
                    result.push(s[i - 9..i + 1].to_string());
                }
            }
        }

        result
    }
}