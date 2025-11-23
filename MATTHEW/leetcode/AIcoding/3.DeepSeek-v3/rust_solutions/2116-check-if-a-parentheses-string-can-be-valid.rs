impl Solution {
    pub fn can_be_valid(s: String, locked: String) -> bool {
        let s_chars: Vec<char> = s.chars().collect();
        let locked_chars: Vec<char> = locked.chars().collect();
        let n = s_chars.len();
        if n % 2 != 0 {
            return false;
        }

        let mut balance = 0;
        for i in 0..n {
            if locked_chars[i] == '0' || s_chars[i] == '(' {
                balance += 1;
            } else {
                balance -= 1;
            }
            if balance < 0 {
                return false;
            }
        }

        balance = 0;
        for i in (0..n).rev() {
            if locked_chars[i] == '0' || s_chars[i] == ')' {
                balance += 1;
            } else {
                balance -= 1;
            }
            if balance < 0 {
                return false;
            }
        }

        true
    }
}