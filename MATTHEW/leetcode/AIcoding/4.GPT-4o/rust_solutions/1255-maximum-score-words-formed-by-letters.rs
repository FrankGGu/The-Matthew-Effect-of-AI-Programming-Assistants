use std::collections::HashMap;

pub fn max_score_words(words: Vec<String>, letters: Vec<char>, score: Vec<i32>) -> i32 {
    let mut letter_count = HashMap::new();
    for &letter in &letters {
        *letter_count.entry(letter).or_insert(0) += 1;
    }

    let mut max_score = 0;

    fn backtrack(words: &[String], score: &[i32], letter_count: &HashMap<char, i32>, index: usize, current_score: i32) -> i32 {
        if index == words.len() {
            return current_score;
        }

        let mut new_letter_count = letter_count.clone();
        let word = &words[index];
        let mut can_form = true;
        let mut word_score = 0;

        for &ch in word.chars() {
            *new_letter_count.entry(ch).or_insert(0) -= 1;
            if new_letter_count[&ch] < 0 {
                can_form = false;
            }
            word_score += score[ch as usize - 'a' as usize];
        }

        let score_with_word = if can_form {
            backtrack(words, score, &new_letter_count, index + 1, current_score + word_score)
        } else {
            0
        };

        let score_without_word = backtrack(words, score, letter_count, index + 1, current_score);

        max_score = score_with_word.max(score_without_word);
        max_score
    }

    backtrack(&words, &score, &letter_count, 0, 0)
}