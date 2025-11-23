impl Solution {
    pub fn are_sentences_similar(s1: String, s2: String) -> bool {
        let mut words1: Vec<&str> = s1.split_whitespace().collect();
        let mut words2: Vec<&str> = s2.split_whitespace().collect();

        if words1.len() == words2.len() {
            return words1 == words2;
        }

        // Ensure words1 is the shorter sentence
        if words1.len() > words2.len() {
            std::mem::swap(&mut words1, &mut words2);
        }

        // Now words1 is the shorter sentence, words2 is the longer sentence
        let mut left1 = 0;
        let mut right1 = words1.len() as i32 - 1; // Use i32 to handle potential -1 for empty words1
        let mut left2 = 0;
        let mut right2 = words2.len() as i32 - 1;

        // Match from the beginning
        while left1 <= right1 && words1[left1 as usize] == words2[left2 as usize] {
            left1 += 1;
            left2 += 1;
        }

        // Match from the end
        while left1 <= right1 && words1[right1 as usize] == words2[right2 as usize] {
            right1 -= 1;
            right2 -= 1;
        }

        // If all words in words1 have been matched (either from beginning or end),
        // then left1 will be greater than right1.
        left1 > right1
    }
}