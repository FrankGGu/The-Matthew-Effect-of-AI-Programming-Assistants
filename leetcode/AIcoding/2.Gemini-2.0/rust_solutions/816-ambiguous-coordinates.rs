impl Solution {
    pub fn ambiguous_coordinates(s: String) -> Vec<String> {
        let s = s[1..s.len() - 1].to_string();
        let n = s.len();
        let mut res = Vec::new();
        for i in 1..n {
            let left = &s[0..i];
            let right = &s[i..n];
            let left_coords = Solution::get_coords(left);
            let right_coords = Solution::get_coords(right);

            for l in &left_coords {
                for r in &right_coords {
                    res.push(format!("({}, {})", l, r));
                }
            }
        }
        res
    }

    fn get_coords(s: &str) -> Vec<String> {
        let n = s.len();
        let mut res = Vec::new();
        if n == 1 {
            res.push(s.to_string());
            return res;
        }

        if s.starts_with('0') && s.ends_with('0') {
            return res;
        }

        if s.starts_with('0') {
            res.push(format!("0.{}", &s[1..n]));
            return res;
        }

        if s.ends_with('0') {
            res.push(s.to_string());
            return res;
        }

        res.push(s.to_string());
        for i in 1..n {
            res.push(format!("{}.{}", &s[0..i], &s[i..n]));
        }
        res
    }
}