use std::collections::HashMap;

impl Solution {
    pub fn longest_palindrome(words: Vec<String>) -> i32 {
        let mut counts: HashMap<String, i32> = HashMap::new();
        for word in &words {
            *counts.entry(word.clone()).or_insert(0) += 1;
        }

        let mut ans = 0;
        let mut center = false;

        for (word, count) in counts.clone().iter() {
            let reversed_word = word.chars().rev().collect::<String>();

            if word == &reversed_word {
                let even_count = count / 2 * 2;
                ans += even_count * 2;
                if count % 2 == 1 {
                    center = true;
                }
            } else if word < &reversed_word {
                if counts.contains_key(&reversed_word) {
                    let reversed_count = counts.get(&reversed_word).unwrap();
                    let min_count = std::cmp::min(count, reversed_count);
                    ans += min_count * 4;
                }
            }
        }

        if center {
            ans += 2;
        }

        ans
    }
}

struct Solution;