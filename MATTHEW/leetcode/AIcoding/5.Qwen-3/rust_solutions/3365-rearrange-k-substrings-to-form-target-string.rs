impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn can_rearrange_pattern(s: String, t: String, k: i32) -> bool {
        if s.len() != t.len() {
            return false;
        }
        let len = s.len();
        let k = k as usize;
        let mut count = HashMap::new();
        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }
        let mut pattern = Vec::new();
        for c in t.chars() {
            pattern.push(c);
        }
        let mut used = vec![false; len];
        let mut result = true;
        for i in 0..len {
            if used[i] {
                continue;
            }
            let target_char = pattern[i];
            let mut found = false;
            for j in 0..len {
                if !used[j] && s.chars().nth(j) == Some(target_char) {
                    used[j] = true;
                    found = true;
                    break;
                }
            }
            if !found {
                result = false;
                break;
            }
        }
        if !result {
            return false;
        }
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }
        for (c, &cnt) in &freq {
            if cnt > 1 {
                let mut total = 0;
                for i in 0..len {
                    if s.chars().nth(i) == Some(*c) {
                        total += 1;
                    }
                }
                if total % k != 0 {
                    return false;
                }
            }
        }
        true
    }
}
}