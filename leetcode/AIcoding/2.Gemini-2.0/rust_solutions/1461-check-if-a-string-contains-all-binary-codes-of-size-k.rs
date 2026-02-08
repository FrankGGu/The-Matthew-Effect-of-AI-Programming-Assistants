impl Solution {
    pub fn has_all_codes(s: String, k: i32) -> bool {
        if k > s.len() as i32 {
            return false;
        }

        let k_usize = k as usize;
        let mut seen = std::collections::HashSet::new();
        let mut count = 0;
        let max_codes = 1 << k;

        for i in 0..=s.len() - k_usize {
            let sub = &s[i..i + k_usize];
            if seen.insert(sub.to_string()) {
                count += 1;
                if count == max_codes {
                    return true;
                }
            }
        }

        count == max_codes
    }
}