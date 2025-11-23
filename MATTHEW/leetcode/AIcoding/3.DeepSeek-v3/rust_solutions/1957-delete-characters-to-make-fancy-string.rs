impl Solution {
    pub fn make_fancy_string(s: String) -> String {
        let mut res = String::new();
        let s_chars: Vec<char> = s.chars().collect();
        let n = s_chars.len();
        if n < 3 {
            return s;
        }
        res.push(s_chars[0]);
        res.push(s_chars[1]);
        for i in 2..n {
            if s_chars[i] != s_chars[i-1] || s_chars[i] != s_chars[i-2] {
                res.push(s_chars[i]);
            }
        }
        res
    }
}