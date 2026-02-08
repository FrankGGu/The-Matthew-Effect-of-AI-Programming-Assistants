impl Solution {
    pub fn max_score_words(words: Vec<String>, letters: Vec<char>, score: Vec<i32>) -> i32 {
        let mut initial_letter_counts = [0; 26];
        for &c in &letters {
            initial_letter_counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut preprocessed_words = Vec::new();
        for word in words {
            let mut word_letter_counts = [0; 26];
            let mut word_score = 0;
            for c in word.chars() {
                let idx = (c as u8 - b'a') as usize;
                word_letter_counts[idx] += 1;
                word_score += score[idx];
            }
            preprocessed_words.push((word_score, word_letter_counts));
        }

        fn solve(
            index: usize,
            current_counts: &mut [i32; 26],
            preprocessed_words: &[(i32, [i32; 26])],
        ) -> i32 {
            if index == preprocessed_words.len() {
                return 0;
            }

            // Option 1: Don't take the current word
            let score_without_word = solve(index + 1, current_counts, preprocessed_words);

            // Option 2: Try to take the current word
            let (word_score, word_req_counts) = &preprocessed_words[index];
            let mut can_take_word = true;
            for i in 0..26 {
                if current_counts[i] < word_req_counts[i] {
                    can_take_word = false;
                    break;
                }
            }

            let mut score_with_word = 0;
            if can_take_word {
                // Temporarily update counts
                for i in 0..26 {
                    current_counts[i] -= word_req_counts[i];
                }

                score_with_word = word_score + solve(index + 1, current_counts, preprocessed_words);

                // Backtrack: restore counts
                for i in 0..26 {
                    current_counts[i] += word_req_counts[i];
                }
            }

            score_without_word.max(score_with_word)
        }

        solve(0, &mut initial_letter_counts, &preprocessed_words)
    }
}