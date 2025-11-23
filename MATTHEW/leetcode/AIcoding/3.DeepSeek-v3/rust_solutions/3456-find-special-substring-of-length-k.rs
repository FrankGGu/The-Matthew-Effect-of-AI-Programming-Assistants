impl Solution {
    pub fn find_special_substring(s: String, k: i32) -> String {
        let k = k as usize;
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        for i in 0..=n - k {
            let substring = &chars[i..i + k];
            let mut unique = std::collections::HashSet::new();
            let mut valid = true;

            for &c in substring {
                if !unique.insert(c) {
                    valid = false;
                    break;
                }
            }

            if valid {
                return substring.iter().collect();
            }
        }

        "".to_string()
    }
}