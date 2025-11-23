impl Solution {
    pub fn max_score_words(words: Vec<String>, letters: Vec<char>, score: Vec<i32>) -> i32 {
        let mut letter_count = vec![0; 26];
        for &c in &letters {
            letter_count[(c as u8 - b'a') as usize] += 1;
        }

        let word_scores: Vec<i32> = words.iter().map(|word| {
            word.chars().map(|c| score[(c as u8 - b'a') as usize]).sum()
        }).collect();

        let word_letter_counts: Vec<Vec<i32>> = words.iter().map(|word| {
            let mut counts = vec![0; 26];
            for c in word.chars() {
                counts[(c as u8 - b'a') as usize] += 1;
            }
            counts
        }).collect();

        let mut max_score = 0;
        let n = words.len();

        for mask in 0..(1 << n) {
            let mut total_score = 0;
            let mut current_counts = vec![0; 26];
            let mut valid = true;

            for i in 0..n {
                if mask & (1 << i) != 0 {
                    for j in 0..26 {
                        current_counts[j] += word_letter_counts[i][j];
                        if current_counts[j] > letter_count[j] {
                            valid = false;
                            break;
                        }
                    }
                    if !valid {
                        break;
                    }
                    total_score += word_scores[i];
                }
            }

            if valid && total_score > max_score {
                max_score = total_score;
            }
        }

        max_score
    }
}