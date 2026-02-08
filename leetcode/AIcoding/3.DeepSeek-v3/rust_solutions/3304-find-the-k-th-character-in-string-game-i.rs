impl Solution {
    pub fn find_kth_character(s: String, k: i32) -> char {
        let mut s = s;
        let mut k = k as usize;
        while s.len() < k {
            let mut next_s = String::new();
            for c in s.chars() {
                if c == '0' {
                    next_s.push_str("01");
                } else {
                    next_s.push_str("10");
                }
            }
            s = next_s;
        }
        s.chars().nth(k - 1).unwrap()
    }
}