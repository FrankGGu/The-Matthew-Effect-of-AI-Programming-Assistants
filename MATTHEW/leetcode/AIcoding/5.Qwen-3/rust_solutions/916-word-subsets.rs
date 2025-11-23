impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn word_subsets(words1: Vec<String>, words2: Vec<String>) -> Vec<String> {
        fn count_chars(s: &str) -> HashMap<char, i32> {
            let mut map = HashMap::new();
            for c in s.chars() {
                *map.entry(c).or_insert(0) += 1;
            }
            map
        }

        let max_freq = words2.iter().fold(HashMap::new(), |mut acc, word| {
            let word_freq = count_chars(word);
            for (c, &cnt) in &word_freq {
                if let Some(e) = acc.get_mut(c) {
                    *e = std::cmp::max(*e, cnt);
                } else {
                    acc.insert(*c, cnt);
                }
            }
            acc
        });

        let mut result = Vec::new();

        for word in &words1 {
            let word_freq = count_chars(word);
            let mut is_subset = true;
            for (c, &cnt) in &max_freq {
                if let Some(&w_cnt) = word_freq.get(c) {
                    if w_cnt < cnt {
                        is_subset = false;
                        break;
                    }
                } else {
                    is_subset = false;
                    break;
                }
            }
            if is_subset {
                result.push(word.clone());
            }
        }

        result
    }
}
}