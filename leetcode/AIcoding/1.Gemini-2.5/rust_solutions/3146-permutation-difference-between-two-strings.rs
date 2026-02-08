impl Solution {
    pub fn find_permutation_difference(s: String, t: String) -> i32 {
        let mut t_char_to_index: [i32; 26] = [0; 26];

        for (i, c) in t.chars().enumerate() {
            t_char_to_index[(c as u8 - b'a') as usize] = i as i32;
        }

        let mut total_difference = 0;
        for (i, c) in s.chars().enumerate() {
            let s_index = i as i32;
            let t_index = t_char_to_index[(c as u8 - b'a') as usize];
            total_difference += (s_index - t_index).abs();
        }

        total_difference
    }
}