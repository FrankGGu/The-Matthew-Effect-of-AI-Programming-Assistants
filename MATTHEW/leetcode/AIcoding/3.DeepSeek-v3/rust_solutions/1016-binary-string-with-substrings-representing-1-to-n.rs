impl Solution {
    pub fn query_string(s: String, n: i32) -> bool {
        for num in 1..=n {
            let binary = format!("{:b}", num);
            if !s.contains(&binary) {
                return false;
            }
        }
        true
    }
}