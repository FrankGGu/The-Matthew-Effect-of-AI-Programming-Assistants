struct Solution;

impl Solution {
    fn count_matches(word1: &str, word2: &str) -> i32 {
        let mut matches = 0;
        for i in 0..6 {
            if word1.as_bytes()[i] == word2.as_bytes()[i] {
                matches += 1;
            }
        }
        matches
    }

    pub fn find_secret_word(words: Vec<String>, master: &Master) {
        let mut possible_words = words;

        for _ in 0..10 {
            if possible_words.is_empty() {
                break;
            }

            let mut best_guess_word_idx = 0;
            let mut min_max_group_size = possible_words.len() + 1;

            for i in 0..possible_words.len() {
                let current_candidate_guess = &possible_words[i];
                let mut group_sizes = [0; 7];

                for j in 0..possible_words.len() {
                    let other_word = &possible_words[j];
                    let matches = Self::count_matches(current_candidate_guess, other_word);
                    group_sizes[matches as usize] += 1;
                }

                let current_max_group_size = *group_sizes.iter().max().unwrap_or(&0);

                if current_max_group_size < min_max_group_size {
                    min_max_group_size = current_max_group_size;
                    best_guess_word_idx = i;
                }
            }

            let guess_word = possible_words[best_guess_word_idx].clone();
            let matches = master.guess(guess_word.clone());

            if matches == 6 {
                return;
            }

            let mut next_possible_words = Vec::new();
            for word in possible_words.iter() {
                if Self::count_matches(&guess_word, word) == matches {
                    next_possible_words.push(word.clone());
                }
            }
            possible_words = next_possible_words;
        }
    }
}