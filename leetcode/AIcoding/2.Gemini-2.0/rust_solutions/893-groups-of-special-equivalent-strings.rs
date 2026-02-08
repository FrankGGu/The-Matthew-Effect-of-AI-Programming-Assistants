use std::collections::HashSet;

impl Solution {
    pub fn num_special_equiv_groups(words: Vec<String>) -> i32 {
        let mut set = HashSet::new();
        for word in words {
            let mut even = Vec::new();
            let mut odd = Vec::new();
            for (i, c) in word.chars().enumerate() {
                if i % 2 == 0 {
                    even.push(c);
                } else {
                    odd.push(c);
                }
            }
            even.sort();
            odd.sort();
            let mut equiv = String::new();
            for c in even {
                equiv.push(c);
            }
            for c in odd {
                equiv.push(c);
            }
            set.insert(equiv);
        }
        set.len() as i32
    }
}