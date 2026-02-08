use std::collections::HashMap;

pub fn word_subsets(A: Vec<String>, B: Vec<String>) -> Vec<String> {
    let mut b_count = vec![0; 26];

    for word in B {
        let mut count = vec![0; 26];
        for ch in word.chars() {
            count[(ch as usize - 'a' as usize)] += 1;
        }
        for i in 0..26 {
            b_count[i] = b_count[i].max(count[i]);
        }
    }

    A.into_iter()
        .filter(|word| {
            let mut count = vec![0; 26];
            for ch in word.chars() {
                count[(ch as usize - 'a' as usize)] += 1;
            }
            (0..26).all(|i| count[i] >= b_count[i])
        })
        .collect()
}