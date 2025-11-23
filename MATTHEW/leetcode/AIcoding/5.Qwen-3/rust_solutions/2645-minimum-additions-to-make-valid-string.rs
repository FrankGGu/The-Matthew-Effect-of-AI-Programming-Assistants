struct Solution;

impl Solution {
    pub fn min_additions(s: String) -> i32 {
        let mut res = 0;
        let mut open = 0;
        for c in s.chars() {
            if c == '(' {
                open += 1;
            } else {
                if open > 0 {
                    open -= 1;
                } else {
                    res += 1;
                }
            }
        }
        res + open
    }
}