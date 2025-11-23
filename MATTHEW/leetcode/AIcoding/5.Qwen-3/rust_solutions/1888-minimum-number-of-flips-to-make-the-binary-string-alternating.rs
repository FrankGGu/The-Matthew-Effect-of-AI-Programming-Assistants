impl Solution {
    pub fn min_flips(s: String) -> i32 {
        let n = s.len();
        let mut count0 = 0;
        let mut count1 = 0;
        for (i, c) in s.chars().enumerate() {
            if i % 2 == 0 {
                if c != '0' {
                    count0 += 1;
                }
                if c != '1' {
                    count1 += 1;
                }
            } else {
                if c != '1' {
                    count0 += 1;
                }
                if c != '0' {
                    count1 += 1;
                }
            }
        }
        let mut res = std::cmp::min(count0, count1);
        for i in 0..n {
            let j = i + n / 2;
            if j >= n {
                break;
            }
            if s.chars().nth(i).unwrap() != s.chars().nth(j).unwrap() {
                res = std::cmp::min(res, count0 - 1);
                res = std::cmp::min(res, count1 - 1);
            }
        }
        res
    }
}