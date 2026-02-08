impl Solution {
    pub fn partition_string(s: String) -> i32 {
        let mut count = 1;
        let mut seen_chars_mask: u32 = 0;

        for c in s.chars() {
            let char_idx = (c as u8 - b'a') as u32;
            let char_bit = 1 << char_idx;

            if (seen_chars_mask & char_bit) != 0 {
                count += 1;
                seen_chars_mask = 0;
            }
            seen_chars_mask |= char_bit;
        }

        count
    }
}