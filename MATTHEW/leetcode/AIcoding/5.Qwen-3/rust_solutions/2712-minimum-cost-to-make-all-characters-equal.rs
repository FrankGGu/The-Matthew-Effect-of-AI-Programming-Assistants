struct Solution;

impl Solution {
    pub fn minimum_cost(s: String) -> i64 {
        let mut res = 0;
        let s = s.as_bytes();
        for i in 1..s.len() {
            if s[i] != s[i - 1] {
                res += (i as i64) * ((s.len() - i) as i64);
            }
        }
        res
    }
}