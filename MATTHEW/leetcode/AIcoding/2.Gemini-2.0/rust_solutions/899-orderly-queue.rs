impl Solution {
    pub fn orderly_queue(s: String, k: i32) -> String {
        if k > 1 {
            let mut chars: Vec<char> = s.chars().collect();
            chars.sort();
            return chars.iter().collect();
        } else {
            let mut min_s = s.clone();
            for i in 1..s.len() {
                let rotated_s = s[i..].to_string() + &s[..i];
                if rotated_s < min_s {
                    min_s = rotated_s;
                }
            }
            return min_s;
        }
    }
}