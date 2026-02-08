impl Solution {
    pub fn min_flips(s: String) -> i32 {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();
        let mut target1 = vec![];
        let mut target2 = vec![];
        for i in 0..n {
            if i % 2 == 0 {
                target1.push('0');
                target2.push('1');
            } else {
                target1.push('1');
                target2.push('0');
            }
        }

        let mut diff1 = 0;
        let mut diff2 = 0;
        let mut res = std::i32::MAX;

        for i in 0..2 * n {
            let r = i % n;
            if s_chars[r] != target1[r] {
                diff1 += 1;
            }
            if s_chars[r] != target2[r] {
                diff2 += 1;
            }

            if i >= n {
                let l = (i - n) % n;
                if s_chars[l] != target1[l] {
                    diff1 -= 1;
                }
                if s_chars[l] != target2[l] {
                    diff2 -= 1;
                }
            }

            if i >= n - 1 {
                res = res.min(diff1.min(diff2));
            }
        }

        res
    }
}