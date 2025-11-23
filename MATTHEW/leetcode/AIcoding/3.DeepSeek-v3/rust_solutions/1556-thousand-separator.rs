impl Solution {
    pub fn thousand_separator(n: i32) -> String {
        let s = n.to_string();
        let mut res = String::new();
        let mut count = 0;
        for c in s.chars().rev() {
            if count == 3 {
                res.push('.');
                count = 0;
            }
            res.push(c);
            count += 1;
        }
        res.chars().rev().collect()
    }
}