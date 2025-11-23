struct Solution;

impl Solution {
    pub fn maximum_score(s: String, power: Vec<i32>) -> i32 {
        let mut s = s.into_bytes();
        let mut power = power;
        let mut score = 0;
        let mut i = 0;
        while i < s.len() {
            let mut j = i;
            while j < s.len() && s[j] == s[i] {
                j += 1;
            }
            if j - i > 1 {
                let idx = s[i] as usize - b'A' as usize;
                score += power[idx] * (j - i) as i32;
                i = j;
            } else {
                i += 1;
            }
        }
        score
    }
}