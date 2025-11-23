impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn check_inclusion(s1: String, s2: String) -> bool {
        if s1.len() > s2.len() {
            return false;
        }

        let mut count_s1 = HashMap::new();
        let mut count_s2 = HashMap::new();

        for c in s1.chars() {
            *count_s1.entry(c).or_insert(0) += 1;
        }

        for i in 0..s1.len() {
            let c = s2.chars().nth(i).unwrap();
            *count_s2.entry(c).or_insert(0) += 1;
        }

        if count_s1 == count_s2 {
            return true;
        }

        for i in s1.len()..s2.len() {
            let out = s2.chars().nth(i - s1.len()).unwrap();
            let in_c = s2.chars().nth(i).unwrap();

            *count_s2.get_mut(&out).unwrap() -= 1;
            if count_s2[&out] == 0 {
                count_s2.remove(&out);
            }

            *count_s2.entry(in_c).or_insert(0) += 1;

            if count_s1 == count_s2 {
                return true;
            }
        }

        false
    }
}
}