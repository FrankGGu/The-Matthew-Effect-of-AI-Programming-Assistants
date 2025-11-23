impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn is_substring_present(s: String, t: String) -> bool {
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        for c in t.chars() {
            if let Some(&mut v) = count.get_mut(&c) {
                *v -= 1;
                if *v == 0 {
                    count.remove(&c);
                }
            } else {
                return false;
            }
        }
        true
    }

    pub fn number_of_substrings(s: String) -> i32 {
        let n = s.len();
        let mut result = 0;
        for i in 0..n {
            let mut freq = HashMap::new();
            for j in i..n {
                let c = s.chars().nth(j).unwrap();
                *freq.entry(c).or_insert(0) += 1;
                if freq.len() == 26 {
                    result += 1;
                    break;
                }
            }
        }
        result
    }

    pub fn number_of_substrings_with_rearrangement(s: String, t: String) -> i32 {
        let n = s.len();
        let mut result = 0;
        for i in 0..n {
            let mut freq = HashMap::new();
            for j in i..n {
                let c = s.chars().nth(j).unwrap();
                *freq.entry(c).or_insert(0) += 1;
                if Self::is_substring_present(t.clone(), s[i..j + 1].to_string()) {
                    result += 1;
                    break;
                }
            }
        }
        result
    }

    pub fn number_of_substrings(s: String, t: String) -> i32 {
        let n = s.len();
        let mut result = 0;
        for i in 0..n {
            let mut freq = HashMap::new();
            for j in i..n {
                let c = s.chars().nth(j).unwrap();
                *freq.entry(c).or_insert(0) += 1;
                if Self::is_substring_present(t.clone(), s[i..j + 1].to_string()) {
                    result += 1;
                    break;
                }
            }
        }
        result
    }
}
}