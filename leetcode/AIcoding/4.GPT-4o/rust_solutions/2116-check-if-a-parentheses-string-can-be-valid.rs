impl Solution {
    pub fn can_be_valid(s: String, locked: String) -> bool {
        let n = s.len();
        if n % 2 != 0 {
            return false;
        }

        let (mut open, mut close) = (0, 0);
        for i in 0..n {
            if locked.chars().nth(i).unwrap() == '0' {
                open += 1;
            } else if s.chars().nth(i).unwrap() == '(' {
                open += 1;
            } else {
                open -= 1;
            }
            if open < 0 {
                return false;
            }
        }

        open = 0;
        for i in (0..n).rev() {
            if locked.chars().nth(i).unwrap() == '0' {
                close += 1;
            } else if s.chars().nth(i).unwrap() == ')' {
                close += 1;
            } else {
                close -= 1;
            }
            if close < 0 {
                return false;
            }
        }
        true
    }
}