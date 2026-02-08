impl Solution {
    pub fn repeated_string_match(a: String, b: String) -> i32 {
        let mut s = String::new();
        let mut count = 0;
        while s.len() < b.len() {
            s.push_str(&a);
            count += 1;
        }
        if s.contains(&b) {
            return count;
        }
        s.push_str(&a);
        count += 1;
        if s.contains(&b) {
            return count;
        }
        -1
    }
}