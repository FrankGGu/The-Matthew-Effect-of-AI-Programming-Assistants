impl Solution {
    pub fn close_strings(word1: String, word2: String) -> bool {
        if word1.len() != word2.len() {
            return false;
        }

        let mut counts1 = vec![0; 26];
        let mut counts2 = vec![0; 26];

        for c in word1.chars() {
            counts1[(c as u8 - b'a') as usize] += 1;
        }

        for c in word2.chars() {
            counts2[(c as u8 - b'a') as usize] += 1;
        }

        for i in 0..26 {
            if (counts1[i] > 0 && counts2[i] == 0) || (counts1[i] == 0 && counts2[i] > 0) {
                return false;
            }
        }

        counts1.sort_unstable();
        counts2.sort_unstable();

        counts1 == counts2
    }
}