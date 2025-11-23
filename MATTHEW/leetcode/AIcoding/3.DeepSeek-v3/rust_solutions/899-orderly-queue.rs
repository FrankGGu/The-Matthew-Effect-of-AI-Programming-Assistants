impl Solution {
    pub fn orderly_queue(s: String, k: i32) -> String {
        if k == 1 {
            let mut min_str = s.clone();
            let mut double_s = s.clone();
            double_s.push_str(&s);
            for i in 1..s.len() {
                let candidate = &double_s[i..i + s.len()];
                if candidate < min_str {
                    min_str = candidate.to_string();
                }
            }
            min_str
        } else {
            let mut chars: Vec<char> = s.chars().collect();
            chars.sort();
            chars.into_iter().collect()
        }
    }
}