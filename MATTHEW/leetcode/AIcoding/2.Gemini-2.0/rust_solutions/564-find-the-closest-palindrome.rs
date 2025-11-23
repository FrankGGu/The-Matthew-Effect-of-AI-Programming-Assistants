impl Solution {
    pub fn nearest_palindromic(n: String) -> String {
        let len = n.len();
        let num = n.parse::<i64>().unwrap();
        let mut candidates: Vec<i64> = Vec::new();

        candidates.push(10_i64.pow(len as u32) + 1);
        candidates.push(10_i64.pow(len as u32 - 1) - 1);

        let prefix = n[0..(len + 1) / 2].parse::<i64>().unwrap();
        for i in -1..=1 {
            let mut p = prefix + i;
            let mut s = p.to_string();
            let mut t = s.chars().rev().collect::<String>();
            if len % 2 == 1 {
                s.pop();
            }
            s.push_str(&t);
            candidates.push(s.parse::<i64>().unwrap());
        }

        let mut ans = -1;
        let mut diff = i64::MAX;

        for c in candidates {
            if c == num {
                continue;
            }
            let d = (c - num).abs();
            if d < diff {
                diff = d;
                ans = c;
            } else if d == diff {
                ans = ans.min(c);
            }
        }

        ans.to_string()
    }
}