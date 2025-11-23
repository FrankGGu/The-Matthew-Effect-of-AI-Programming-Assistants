struct Solution {}

impl Solution {
    pub fn minimum_operations(num: String) -> i32 {
        let s = num.as_str();
        let n = s.len();
        let mut res = n as i32;

        for i in 0..n {
            if s.chars().nth(i).unwrap() == '0' {
                for j in 0..i {
                    if s.chars().nth(j).unwrap() == '0' {
                        res = (res.min((n - 1 - i) as i32 + (i - j - 1) as i32));
                        break;
                    }
                }
            }
        }

        res
    }
}