impl Solution {
    pub fn rearrange_characters(s: String, target: String) -> i32 {
        let mut s_counts = [0; 26];
        let mut target_counts = [0; 26];

        for c in s.chars() {
            s_counts[(c as u8 - b'a') as usize] += 1;
        }

        for c in target.chars() {
            target_counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut min_copies = i32::MAX;
        for i in 0..26 {
            if target_counts[i] > 0 {
                let copies = s_counts[i] / target_counts[i];
                if copies < min_copies {
                    min_copies = copies;
                }
            }
        }

        min_copies
    }
}