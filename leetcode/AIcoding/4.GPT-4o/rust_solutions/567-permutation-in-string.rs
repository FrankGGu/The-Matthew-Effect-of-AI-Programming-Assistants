use std::collections::HashMap;

pub fn check_inclusion(s1: String, s2: String) -> bool {
    let (n, m) = (s1.len(), s2.len());
    if n > m {
        return false;
    }

    let mut s1_count = HashMap::new();
    let mut s2_count = HashMap::new();

    for c in s1.chars() {
        *s1_count.entry(c).or_insert(0) += 1;
    }

    for c in s2.chars().take(n) {
        *s2_count.entry(c).or_insert(0) += 1;
    }

    if s1_count == s2_count {
        return true;
    }

    for i in n..m {
        let c_in = s2.chars().nth(i).unwrap();
        let c_out = s2.chars().nth(i - n).unwrap();

        *s2_count.entry(c_in).or_insert(0) += 1;
        *s2_count.entry(c_out).or_insert(0) -= 1;

        if s2_count[c_out] == 0 {
            s2_count.remove(&c_out);
        }

        if s1_count == s2_count {
            return true;
        }
    }

    false
}