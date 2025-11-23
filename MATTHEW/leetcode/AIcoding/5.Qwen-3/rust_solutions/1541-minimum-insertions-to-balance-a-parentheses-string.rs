struct Solution;

impl Solution {
    pub fn min_insertions(s: String) -> i32 {
        let mut res = 0;
        let mut balance = 0;
        let mut left = 0;

        for c in s.chars() {
            if c == '(' {
                left += 1;
                balance += 1;
                if balance % 2 == 0 {
                    left = 0;
                } else {
                    left = 1;
                }
            } else {
                balance -= 1;
                if balance < 0 {
                    res += 1;
                    balance += 2;
                    left = 1;
                } else {
                    left = 0;
                }
            }
        }

        res + balance + left
    }
}