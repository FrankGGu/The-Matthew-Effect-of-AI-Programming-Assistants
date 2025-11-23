use std::collections::HashSet;

impl Solution {
    pub fn max_partitions_after_operations(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut ans = 0;
        let mut mask = 0;
        for i in 0..n {
            let val = 1 << (s[i] as u32 - 'a' as u32);
            if (mask & val) > 0 {
                ans += 1;
                mask = 0;
            }
            mask |= val;
        }
        ans += 1;

        if ans > 1 {
            let mut unique_chars = HashSet::new();
            for &c in &s {
                unique_chars.insert(c);
            }
            if unique_chars.len() < 26 {
                ans -= 1;
            }
        }

        ans
    }
}