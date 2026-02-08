impl Solution {
    pub fn mirror_score(s: String) -> i32 {
        let n = s.len();
        let mid = n / 2;
        let mut score = 0;

        for (i, c) in s.chars().enumerate() {
            if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' {
                score += 1;
            }
            if i < mid && c == s[n - 1 - i] {
                score += 1;
            }
        }

        score
    }
}