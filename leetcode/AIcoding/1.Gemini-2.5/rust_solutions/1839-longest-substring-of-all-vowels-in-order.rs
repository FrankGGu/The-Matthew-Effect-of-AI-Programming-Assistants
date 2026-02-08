impl Solution {
    pub fn longest_substring_of_all_vowels_in_order(word: String) -> i32 {
        let vowels = ['a', 'e', 'i', 'o', 'u'];
        let mut max_len = 0;
        let mut current_len = 0;
        let mut vowel_idx = 0; // 0 for 'a', 1 for 'e', ..., 4 for 'u'

        for c in word.chars() {
            if c == vowels[vowel_idx] {
                current_len += 1;
            } else if vowel_idx < 4 && c == vowels[vowel_idx + 1] {
                vowel_idx += 1;
                current_len += 1;
            } else { // Sequence broken or character is not a vowel in the expected order
                if c == 'a' {
                    current_len = 1;
                    vowel_idx = 0;
                } else {
                    // If it's not 'a' and breaks the sequence, reset completely
                    current_len = 0;
                    vowel_idx = 0;
                }
            }

            // Only update max_len if we have successfully reached 'u'
            if vowel_idx == 4 {
                max_len = max_len.max(current_len);
            }
        }

        max_len
    }
}