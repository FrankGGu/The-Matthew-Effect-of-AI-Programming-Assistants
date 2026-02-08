impl Solution {
    pub fn min_flips(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut s2 = s.clone();
        for _ in 0..n {
            s2.push(s2[0]);
            s2.remove(0);
        }
        let s2 = s2;
        let mut s_alt1 = Vec::new();
        let mut s_alt2 = Vec::new();
        for i in 0..2 * n {
            if i % 2 == 0 {
                s_alt1.push('0');
                s_alt2.push('1');
            } else {
                s_alt1.push('1');
                s_alt2.push('0');
            }
        }

        let mut flips1 = 0;
        let mut flips2 = 0;
        for i in 0..n {
            if s[i] != s_alt1[i] {
                flips1 += 1;
            }
            if s[i] != s_alt2[i] {
                flips2 += 1;
            }
        }
        let mut min_flips = std::cmp::min(flips1, flips2);

        for i in 0..n - 1 {
            if s[i] != s_alt1[i] {
                flips1 -= 1;
            } else {
                flips1 += 1;
            }
            if s[i] != s_alt2[i] {
                flips2 -= 1;
            } else {
                flips2 += 1;
            }
            if s[i + n] != s_alt1[i + n] {
                flips1 += 1;
            } else {
                flips1 -= 1;
            }
            if s[i + n] != s_alt2[i + n] {
                flips2 += 1;
            } else {
                flips2 -= 1;
            }

            min_flips = std::cmp::min(min_flips, std::cmp::min(flips1, flips2));
        }
        min_flips
    }
}