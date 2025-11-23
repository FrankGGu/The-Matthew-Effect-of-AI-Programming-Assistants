use std::collections::HashMap;

impl Solution {
    pub fn is_it_possible(word1: String, word2: String) -> bool {
        let mut freq1: HashMap<char, i32> = HashMap::new();
        let mut freq2: HashMap<char, i32> = HashMap::new();

        for c in word1.chars() {
            *freq1.entry(c).or_insert(0) += 1;
        }
        for c in word2.chars() {
            *freq2.entry(c).or_insert(0) += 1;
        }

        let distinct1 = freq1.len();
        let distinct2 = freq2.len();

        for (&c1, &count1) in &freq1 {
            for (&c2, &count2) in &freq2 {
                let mut new_freq1 = freq1.clone();
                let mut new_freq2 = freq2.clone();

                *new_freq1.entry(c1).or_insert(0) -= 1;
                if new_freq1[&c1] == 0 {
                    new_freq1.remove(&c1);
                }
                *new_freq1.entry(c2).or_insert(0) += 1;

                *new_freq2.entry(c2).or_insert(0) -= 1;
                if new_freq2[&c2] == 0 {
                    new_freq2.remove(&c2);
                }
                *new_freq2.entry(c1).or_insert(0) += 1;

                if new_freq1.len() == new_freq2.len() {
                    return true;
                }
            }
        }

        false
    }
}