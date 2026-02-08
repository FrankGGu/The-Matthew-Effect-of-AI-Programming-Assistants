use std::collections::HashSet;

impl Solution {
    pub fn num_good_ways(s: String) {
        let s = s.as_bytes();
        let n = s.len();
        let mut left = HashSet::new();
        let mut right = HashSet::new();
        let mut right_count = vec![0; n];
        for i in (0..n).rev() {
            right.insert(s[i]);
            right_count[i] = right.len();
        }
        let mut ans = 0;
        for i in 0..n - 1 {
            left.insert(s[i]);
            if left.len() == right_count[i + 1] {
                ans += 1;
            }
        }
        ans
    }
}