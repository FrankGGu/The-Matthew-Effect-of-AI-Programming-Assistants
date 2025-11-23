impl Solution {
    pub fn nearest_palindromic(n: String) -> String {
        let num = n.parse::<i64>().unwrap();
        let len = n.len();
        let candidates = {
            let mut v = vec![];
            v.push(10i64.pow(len as u32) + 1);
            v.push(10i64.pow(len as u32 - 1) - 1);
            let half = (len + 1) / 2;
            let prefix = n[..half].parse::<i64>().unwrap();
            for &p in &[prefix - 1, prefix, prefix + 1] {
                let s = p.to_string();
                let rev = if len % 2 == 0 {
                    s.chars().rev().collect::<String>()
                } else {
                    s.chars().rev().skip(1).collect::<String>()
                };
                let cand = format!("{}{}", s, rev).parse::<i64>().unwrap();
                v.push(cand);
            }
            v
        };

        let mut res = -1;
        let mut min_diff = i64::MAX;
        for &cand in &candidates {
            if cand == num {
                continue;
            }
            let diff = (cand - num).abs();
            if diff < min_diff || (diff == min_diff && cand < res) {
                min_diff = diff;
                res = cand;
            }
        }
        res.to_string()
    }
}