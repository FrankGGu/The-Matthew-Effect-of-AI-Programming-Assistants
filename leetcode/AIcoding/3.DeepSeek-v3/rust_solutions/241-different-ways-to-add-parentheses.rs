impl Solution {
    pub fn diff_ways_to_compute(expression: String) -> Vec<i32> {
        let mut res = Vec::new();
        let chars: Vec<char> = expression.chars().collect();
        for i in 0..chars.len() {
            let c = chars[i];
            if c == '+' || c == '-' || c == '*' {
                let left = Self::diff_ways_to_compute(chars[..i].iter().collect());
                let right = Self::diff_ways_to_compute(chars[i + 1..].iter().collect());
                for &l in &left {
                    for &r in &right {
                        match c {
                            '+' => res.push(l + r),
                            '-' => res.push(l - r),
                            '*' => res.push(l * r),
                            _ => (),
                        }
                    }
                }
            }
        }
        if res.is_empty() {
            res.push(expression.parse().unwrap());
        }
        res
    }
}