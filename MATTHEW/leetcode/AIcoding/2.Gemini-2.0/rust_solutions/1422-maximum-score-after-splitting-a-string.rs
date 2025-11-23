impl Solution {
    pub fn max_score(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut max_score = 0;
        for i in 1..n {
            let mut score = 0;
            for j in 0..i {
                if s_bytes[j] == b'0' {
                    score += 1;
                }
            }
            for j in i..n {
                if s_bytes[j] == b'1' {
                    score += 1;
                }
            }
            max_score = max_score.max(score);
        }
        max_score
    }
}