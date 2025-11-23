use std::collections::HashMap;

impl Solution {
    pub fn permutation_difference(s1: String, s2: String) -> i32 {
        let n1 = s1.len();
        let n2 = s2.len();
        let mut count = 0;

        if n1 > n2 {
            return 0;
        }

        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();

        let mut s1_freq: HashMap<char, i32> = HashMap::new();
        for &c in &s1_chars {
            *s1_freq.entry(c).or_insert(0) += 1;
        }

        for i in 0..=(n2 - n1) {
            let mut sub_freq: HashMap<char, i32> = HashMap::new();
            for j in 0..n1 {
                *sub_freq.entry(s2_chars[i + j]).or_insert(0) += 1;
            }

            if s1_freq == sub_freq {
                count += 1;
            }
        }

        count
    }
}