impl Solution {
    pub fn score_of_string(s: String) -> i32 {
        let bytes = s.as_bytes();
        let mut score = 0;
        for i in 0..bytes.len() - 1 {
            score += (bytes[i] as i32 - bytes[i + 1] as i32).abs();
        }
        score
    }
}