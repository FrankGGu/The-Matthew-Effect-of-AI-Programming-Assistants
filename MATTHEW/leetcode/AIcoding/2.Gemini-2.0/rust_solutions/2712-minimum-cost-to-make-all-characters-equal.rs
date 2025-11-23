impl Solution {
    pub fn minimum_cost(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut cost = 0;
        for i in 0..n - 1 {
            if s_bytes[i] != s_bytes[i + 1] {
                cost += (i + 1).min(n - i - 1) as i32;
            }
        }
        cost
    }
}