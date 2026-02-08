impl Solution {
    pub fn ambiguous_coordinates(s: String) -> Vec<String> {
        let s = &s[1..s.len() - 1];
        let mut res = Vec::new();
        for i in 1..s.len() {
            let left = &s[..i];
            let right = &s[i..];
            let left_nums = Self::generate_numbers(left);
            let right_nums = Self::generate_numbers(right);
            for l in &left_nums {
                for r in &right_nums {
                    res.push(format!("({}, {})", l, r));
                }
            }
        }
        res
    }

    fn generate_numbers(s: &str) -> Vec<String> {
        let mut res = Vec::new();
        if s == "0" {
            return vec!["0".to_string()];
        }
        if s.starts_with('0') {
            if s.ends_with('0') {
                return res;
            }
            res.push(format!("0.{}", &s[1..]));
            return res;
        }
        if s.ends_with('0') {
            res.push(s.to_string());
            return res;
        }
        res.push(s.to_string());
        for i in 1..s.len() {
            res.push(format!("{}.{}", &s[..i], &s[i..]));
        }
        res
    }
}