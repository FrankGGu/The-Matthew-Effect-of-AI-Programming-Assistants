impl Solution {
    pub fn check_almost_equivalent(word1: String, word2: String) -> bool {
        let mut freq1 = [0; 26];
        let mut freq2 = [0; 26];

        for c in word1.chars() {
            freq1[(c as u8 - b'a') as usize] += 1;
        }

        for c in word2.chars() {
            freq2[(c as u8 - b'a') as usize] += 1;
        }

        for i in 0..26 {
            if (freq1[i] as i32 - freq2[i] as i32).abs() > 3 {
                return false;
            }
        }

        true
    }
}