impl Solution {
    pub fn max_score_words(words: Vec<String>, letters: Vec<char>, score: Vec<i32>) -> i32 {
        let mut letter_counts = vec![0; 26];
        for &c in &letters {
            letter_counts[c as usize - 'a' as usize] += 1;
        }

        fn solve(
            index: usize,
            words: &Vec<String>,
            letter_counts: &mut Vec<i32>,
            score: &Vec<i32>,
        ) -> i32 {
            if index == words.len() {
                return 0;
            }

            let mut skip = solve(index + 1, words, letter_counts, score);

            let mut current_score = 0;
            let mut possible = true;
            let mut temp_counts = letter_counts.clone();

            for &c in words[index].chars() {
                let char_index = c as usize - 'a' as usize;
                if temp_counts[char_index] == 0 {
                    possible = false;
                    break;
                }
                temp_counts[char_index] -= 1;
                current_score += score[char_index];
            }

            if possible {
                *letter_counts = temp_counts;
                let include = current_score + solve(index + 1, words, letter_counts, score);
                *letter_counts = letter_counts.clone(); // Restore letter counts
                skip = skip.max(include);
            }

            skip
        }

        let mut letter_counts = letter_counts;
        solve(0, &words, &mut letter_counts, &score)
    }
}