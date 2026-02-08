impl Solution {
    pub fn score_of_string(s: String) -> i32 {
        let mut score = 0;
        let bytes = s.as_bytes();
        for i in 1..bytes.len() {
            score += (bytes[i - 1] as i32 - bytes[i] as i32).abs();
        }
        score
    }
}