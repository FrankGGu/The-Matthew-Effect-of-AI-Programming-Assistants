impl Solution {
    pub fn close_strings(word1: String, word2: String) -> bool {
        if word1.len() != word2.len() {
            return false;
        }

        let mut freq1 = vec![0; 26];
        let mut freq2 = vec![0; 26];

        for c in word1.chars() {
            freq1[(c as u8 - b'a') as usize] += 1;
        }

        for c in word2.chars() {
            freq2[(c as u8 - b'a') as usize] += 1;
        }

        for i in 0..26 {
            if (freq1[i] > 0 && freq2[i] == 0) || (freq1[i] == 0 && freq2[i] > 0) {
                return false;
            }
        }

        freq1.sort();
        freq2.sort();

        freq1 == freq2
    }
}