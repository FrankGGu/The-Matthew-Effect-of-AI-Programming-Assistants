impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn minimum_string(a: String, b: String, c: String) -> String {
        fn contains(s: &str, t: &str) -> bool {
            let mut it = s.chars();
            t.chars().all(|ch| {
                while let Some(c) = it.next() {
                    if c == ch {
                        return true;
                    }
                }
                false
            })
        }

        fn merge(s1: &str, s2: &str) -> String {
            if contains(s1, s2) {
                s1.to_string()
            } else if contains(s2, s1) {
                s2.to_string()
            } else {
                let mut result = s1.to_string();
                let mut i = 0;
                while i < s2.len() {
                    let mut j = 0;
                    while j < s1.len() && i + j < s2.len() {
                        if s1.chars().nth(j) == s2.chars().nth(i + j) {
                            j += 1;
                        } else {
                            break;
                        }
                    }
                    if j == s1.len() {
                        result.push_str(&s2[i..]);
                        break;
                    }
                    i += 1;
                }
                result
            }
        }

        let mut candidates = HashSet::new();
        for perm in [0, 1, 2].permutations(3) {
            let (i, j, k) = (perm[0], perm[1], perm[2]);
            let s = match i {
                0 => a.clone(),
                1 => b.clone(),
                2 => c.clone(),
                _ => unreachable!(),
            };
            let s = merge(&s, match j {
                0 => &a,
                1 => &b,
                2 => &c,
                _ => unreachable!(),
            });
            let s = merge(&s, match k {
                0 => &a,
                1 => &b,
                2 => &c,
                _ => unreachable!(),
            });
            candidates.insert(s);
        }

        candidates.into_iter().min().unwrap()
    }
}
}