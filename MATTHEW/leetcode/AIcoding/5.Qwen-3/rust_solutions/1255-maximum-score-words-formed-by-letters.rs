impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_score_words(words: Vec<String>) -> i32 {
        let mut count = [0; 26];
        for word in &words {
            for c in word.chars() {
                count[c as usize - 'a' as usize] += 1;
            }
        }

        let score = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 9, 4, 10];
        let mut result = 0;
        Self::backtrack(&words, &score, &mut count, 0, 0, &mut result);
        result
    }

    fn backtrack(
        words: &[String],
        score: &[i32],
        count: &mut [i32; 26],
        index: usize,
        current_score: i32,
        result: &mut i32,
    ) {
        if index == words.len() {
            *result = std::cmp::max(*result, current_score);
            return;
        }

        let word = &words[index];
        let mut can_use = true;
        let mut temp_count = [0; 26];

        for c in word.chars() {
            let idx = c as usize - 'a' as usize;
            if count[idx] == 0 {
                can_use = false;
                break;
            }
            temp_count[idx] += 1;
        }

        if can_use {
            for c in word.chars() {
                let idx = c as usize - 'a' as usize;
                count[idx] -= 1;
            }

            let word_score = word.chars().map(|c| score[c as usize - 'a' as usize]).sum::<i32>();
            Self::backtrack(words, score, count, index + 1, current_score + word_score, result);

            for c in word.chars() {
                let idx = c as usize - 'a' as usize;
                count[idx] += 1;
            }
        }

        Self::backtrack(words, score, count, index + 1, current_score, result);
    }
}
}