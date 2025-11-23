use std::collections::HashMap;

impl Solution {
    pub fn is_it_possible(word1: String, word2: String) -> bool {
        let mut count1 = HashMap::new();
        let mut count2 = HashMap::new();

        for c in word1.chars() {
            *count1.entry(c).or_insert(0) += 1;
        }

        for c in word2.chars() {
            *count2.entry(c).or_insert(0) += 1;
        }

        for (&c1, &cnt1) in count1.iter() {
            for (&c2, &cnt2) in count2.iter() {
                let mut new_count1 = count1.clone();
                let mut new_count2 = count2.clone();

                *new_count1.entry(c1).or_insert(0) -= 1;
                if new_count1[&c1] == 0 {
                    new_count1.remove(&c1);
                }

                *new_count1.entry(c2).or_insert(0) += 1;

                *new_count2.entry(c2).or_insert(0) -= 1;
                if new_count2[&c2] == 0 {
                    new_count2.remove(&c2);
                }

                *new_count2.entry(c1).or_insert(0) += 1;

                if new_count1.len() == new_count2.len() {
                    return true;
                }
            }
        }

        false
    }
}