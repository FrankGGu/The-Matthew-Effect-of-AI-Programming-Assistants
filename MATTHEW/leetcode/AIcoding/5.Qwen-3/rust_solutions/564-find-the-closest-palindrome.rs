struct Solution;

impl Solution {
    pub fn nearest_palindrome(n: String) -> String {
        let mut num = n.parse::<i64>().unwrap();
        let mut candidates = Vec::new();
        let len = n.len();

        for i in 0..=len {
            let prefix = &n[..(len + 1) / 2];
            let mut p = prefix.parse::<i64>().unwrap();
            for delta in [-1, 0, 1] {
                let mut candidate = format!("{}", p + delta);
                if i == 0 {
                    candidate = "1".to_string();
                } else if i == len {
                    candidate = "9".to_string();
                }
                if i < len {
                    let mut s = candidate.clone();
                    if len % 2 == 0 {
                        s.push_str(&candidate[..]);
                    } else {
                        s.push_str(&candidate[..len - i]);
                    }
                    candidates.push(s);
                } else {
                    candidates.push(candidate);
                }
            }
        }

        candidates.sort_by(|a, b| {
            let a_num = a.parse::<i64>().unwrap();
            let b_num = b.parse::<i64>().unwrap();
            let a_diff = (a_num - num).abs();
            let b_diff = (b_num - num).abs();
            if a_diff != b_diff {
                a_diff.cmp(&b_diff)
            } else {
                a_num.cmp(&b_num)
            }
        });

        candidates[0].clone()
    }
}