use std::collections::HashSet;

impl Solution {
    pub fn similar_pairs(words: Vec<String>) -> i32 {
        let mut count = 0;
        let n = words.len();
        let mut sets: Vec<HashSet<char>> = Vec::with_capacity(n);

        for word in words {
            let mut set = HashSet::new();
            for c in word.chars() {
                set.insert(c);
            }
            sets.push(set);
        }

        for i in 0..n {
            for j in i + 1..n {
                if sets[i] == sets[j] {
                    count += 1;
                }
            }
        }

        count
    }
}