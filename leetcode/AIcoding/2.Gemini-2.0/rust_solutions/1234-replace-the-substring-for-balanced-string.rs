use std::collections::HashMap;

impl Solution {
    pub fn balanced_string(s: String) -> i32 {
        let n = s.len();
        let k = n / 4;
        let mut counts = HashMap::new();
        for c in s.chars() {
            *counts.entry(c).or_insert(0) += 1;
        }

        let mut l = 0;
        let mut ans = n as i32;
        for r in 0..n {
            *counts.entry(s.chars().nth(r).unwrap()).or_insert(0) -= 1;

            while counts.get(&'Q').unwrap_or(&0) <= &k &&
                  counts.get(&'W').unwrap_or(&0) <= &k &&
                  counts.get(&'E').unwrap_or(&0) <= &k &&
                  counts.get(&'R').unwrap_or(&0) <= &k {
                ans = ans.min((r - l + 1) as i32);
                *counts.entry(s.chars().nth(l).unwrap()).or_insert(0) += 1;
                l += 1;
            }
        }

        ans
    }
}