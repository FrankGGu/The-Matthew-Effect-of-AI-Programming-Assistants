impl Solution {
    pub fn rearrange_characters(s: String, target: String) -> i32 {
        let mut s_counts = [0; 26];
        for c in s.chars() {
            s_counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut target_counts = [0; 26];
        for c in target.chars() {
            target_counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut max_copies = i32::MAX;

        for i in 0..26 {
            let target_char_count = target_counts[i];
            if target_char_count > 0 {
                let s_char_count = s_counts[i];
                max_copies = max_copies.min(s_char_count / target_char_count);
            }
        }

        max_copies
    }
}