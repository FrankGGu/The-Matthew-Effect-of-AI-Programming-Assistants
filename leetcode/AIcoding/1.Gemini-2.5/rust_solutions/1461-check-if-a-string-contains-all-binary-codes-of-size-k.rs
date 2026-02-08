use std::collections::HashSet;

impl Solution {
    pub fn has_all_codes(s: String, k: i32) -> bool {
        let k_usize = k as usize;
        let n = s.len();

        if n < k_usize {
            return false;
        }

        let mut seen_codes: HashSet<u32> = HashSet::new();
        let mut current_code: u32 = 0;
        let all_codes_count = 1 << k; // 2^k
        let mask: u32 = (1 << k) - 1; // Mask to keep only the last k bits

        let bytes = s.as_bytes();

        for i in 0..n {
            // Shift left and add the new bit
            current_code = (current_code << 1) | (bytes[i] as u32 - b'0' as u32);

            // Once we have processed at least k characters,
            // current_code holds a k-bit binary string.
            if i >= k_usize - 1 {
                // Apply the mask to ensure we only keep the last k bits.
                seen_codes.insert(current_code & mask);

                // If we have found all possible 2^k codes, return true
                if seen_codes.len() == all_codes_count {
                    return true;
                }
            }
        }

        // If the loop finishes and we haven't found all codes
        false
    }
}