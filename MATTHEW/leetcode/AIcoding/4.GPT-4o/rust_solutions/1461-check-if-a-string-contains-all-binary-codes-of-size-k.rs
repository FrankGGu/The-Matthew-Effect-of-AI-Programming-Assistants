impl Solution {
    pub fn has_all_codes(s: String, k: i32) -> bool {
        let n = s.len();
        let k = k as usize;
        let total_codes = 1 << k;
        let mut seen = std::collections::HashSet::new();

        for i in 0..=n - k {
            let code = &s[i..i + k];
            seen.insert(code);
            if seen.len() == total_codes {
                return true;
            }
        }
        false
    }
}