impl Solution {
    pub fn min_add_to_make_valid(s: String) -> i32 {
        let mut balance = 0;
        let mut additions = 0;

        for c in s.chars() {
            if c == '(' {
                balance += 1;
            } else {
                if balance > 0 {
                    balance -= 1;
                } else {
                    additions += 1;
                }
            }
        }

        additions + balance
    }
}