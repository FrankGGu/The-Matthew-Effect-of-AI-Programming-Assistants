impl Solution {
    pub fn beautiful_indices(s: String, a: String, b: String, k: i32) -> Vec<i32> {
        let s_chars: Vec<char> = s.chars().collect();
        let a_chars: Vec<char> = a.chars().collect();
        let b_chars: Vec<char> = b.chars().collect();

        let mut a_indices = Vec::new();
        let mut b_indices = Vec::new();

        if a_chars.len() == 0 || b_chars.len() == 0 || s_chars.len() < a_chars.len() || s_chars.len() < b_chars.len() {
            return Vec::new();
        }

        for i in 0..=(s_chars.len() - a_chars.len()) {
            let mut matched = true;
            for j in 0..a_chars.len() {
                if s_chars[i + j] != a_chars[j] {
                    matched = false;
                    break;
                }
            }
            if matched {
                a_indices.push(i as i32);
            }
        }

        for i in 0..=(s_chars.len() - b_chars.len()) {
            let mut matched = true;
            for j in 0..b_chars.len() {
                if s_chars[i + j] != b_chars[j] {
                    matched = false;
                    break;
                }
            }
            if matched {
                b_indices.push(i as i32);
            }
        }

        let mut result = Vec::new();
        for &i in &a_indices {
            let mut found = false;
            for &j in &b_indices {
                if (i - j).abs() <= k {
                    found = true;
                    break;
                }
            }
            if found {
                result.push(i);
            }
        }

        result
    }
}