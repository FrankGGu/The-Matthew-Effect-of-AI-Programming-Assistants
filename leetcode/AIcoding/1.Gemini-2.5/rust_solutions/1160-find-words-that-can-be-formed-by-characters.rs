impl Solution {
    pub fn sum_of_lengths(words: Vec<String>, chars: String) -> i32 {
        let mut char_counts = [0; 26];
        for c in chars.bytes() {
            char_counts[(c - b'a') as usize] += 1;
        }

        let mut total_length = 0;

        for word in words {
            let mut word_counts = [0; 26];
            for c in word.bytes() {
                word_counts[(c - b'a') as usize] += 1;
            }

            let mut can_form = true;
            for i in 0..26 {
                if word_counts[i] > char_counts[i] {
                    can_form = false;
                    break;
                }
            }

            if can_form {
                total_length += word.len() as i32;
            }
        }

        total_length
    }
}