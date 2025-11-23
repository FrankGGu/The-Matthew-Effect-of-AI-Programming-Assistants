impl Solution {
    pub fn min_flips(s: String) -> i32 {
        let n = s.len();
        let s = format!("{}{}", s, &s[..2]);
        let (mut count1, mut count2) = (0, 0);

        for (i, c) in s.chars().enumerate() {
            if c != if i % 2 == 0 { '0' } else { '1' } {
                count1 += 1;
            }
            if c != if i % 2 == 0 { '1' } else { '0' } {
                count2 += 1;
            }
            if i >= n {
                if s.chars().nth(i - n).unwrap() != if (i - n) % 2 == 0 { '0' } else { '1' } {
                    count1 -= 1;
                }
                if s.chars().nth(i - n).unwrap() != if (i - n) % 2 == 0 { '1' } else { '0' } {
                    count2 -= 1;
                }
            }
        }
        count1.min(count2)
    }
}