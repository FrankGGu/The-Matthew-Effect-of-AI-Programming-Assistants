impl Solution {
    pub fn print_kb(s: String, k: i32) -> String {
        let mut res = String::new();
        for c in s.chars() {
            for _ in 0..k {
                res.push(c);
            }
        }
        res
    }
}