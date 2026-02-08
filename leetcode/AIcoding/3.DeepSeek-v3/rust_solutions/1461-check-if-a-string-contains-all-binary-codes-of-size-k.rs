impl Solution {
    pub fn has_all_codes(s: String, k: i32) -> bool {
        let k = k as usize;
        let mut seen = std::collections::HashSet::new();
        let s: Vec<char> = s.chars().collect();
        if s.len() < k {
            return false;
        }
        for i in 0..=s.len() - k {
            let slice = &s[i..i + k];
            seen.insert(slice.iter().collect::<String>());
        }
        seen.len() == (1 << k)
    }
}