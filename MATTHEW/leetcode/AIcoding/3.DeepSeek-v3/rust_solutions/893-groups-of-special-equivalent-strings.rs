use std::collections::HashSet;

impl Solution {
    pub fn num_special_equiv_groups(words: Vec<String>) -> i32 {
        let mut set = HashSet::new();
        for word in words {
            let mut odd = vec![0; 26];
            let mut even = vec![0; 26];
            for (i, c) in word.chars().enumerate() {
                if i % 2 == 0 {
                    even[(c as u8 - b'a') as usize] += 1;
                } else {
                    odd[(c as u8 - b'a') as usize] += 1;
                }
            }
            set.insert((odd, even));
        }
        set.len() as i32
    }
}