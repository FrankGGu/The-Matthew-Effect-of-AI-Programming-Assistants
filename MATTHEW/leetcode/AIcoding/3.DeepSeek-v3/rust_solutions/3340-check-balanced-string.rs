impl Solution {
    pub fn check_balanced_string(s: String) -> bool {
        let mut balance = 0;
        for c in s.chars() {
            match c {
                '(' => balance += 1,
                ')' => balance -= 1,
                _ => (),
            }
            if balance < 0 {
                return false;
            }
        }
        balance == 0
    }
}