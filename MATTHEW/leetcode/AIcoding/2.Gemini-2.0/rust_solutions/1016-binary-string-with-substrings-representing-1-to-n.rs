impl Solution {
    pub fn query_string(s: String, n: i32) -> bool {
        for i in (n / 2 + 1)..=n {
            let binary = format!("{:b}", i);
            if !s.contains(&binary) {
                return false;
            }
        }
        true
    }
}