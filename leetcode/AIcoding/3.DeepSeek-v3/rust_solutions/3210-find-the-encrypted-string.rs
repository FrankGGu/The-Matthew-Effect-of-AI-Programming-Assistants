impl Solution {
    pub fn encrypted_string(s: String) -> String {
        let n = s.len();
        if n <= 1 {
            return s;
        }
        let mid = if n % 2 == 0 { (n / 2) - 1 } else { n / 2 };
        let left = &s[..mid];
        let right = &s[mid + 1..];
        let mut res = String::new();
        res.push(s.chars().nth(mid).unwrap());
        res.push_str(&Solution::encrypted_string(left.to_string()));
        res.push_str(&Solution::encrypted_string(right.to_string()));
        res
    }
}