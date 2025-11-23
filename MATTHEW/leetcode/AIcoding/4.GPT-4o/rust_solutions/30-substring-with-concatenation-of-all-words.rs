use std::collections::HashMap;

pub fn find_substring(s: String, words: Vec<String>) -> Vec<i32> {
    let word_len = words[0].len();
    let word_count = words.len();
    let total_len = word_len * word_count;
    let mut result = Vec::new();
    let mut word_map = HashMap::new();

    for word in &words {
        *word_map.entry(word.as_str()).or_insert(0) += 1;
    }

    for i in 0..s.len() - total_len + 1 {
        let mut seen = HashMap::new();
        let mut j = 0;

        while j < word_count {
            let start = i + j * word_len;
            let end = start + word_len;
            let word = &s[start..end];

            if let Some(&count) = word_map.get(word) {
                *seen.entry(word).or_insert(0) += 1;
                if seen[word] > count {
                    break;
                }
            } else {
                break;
            }

            j += 1;
        }

        if j == word_count {
            result.push(i as i32);
        }
    }

    result
}