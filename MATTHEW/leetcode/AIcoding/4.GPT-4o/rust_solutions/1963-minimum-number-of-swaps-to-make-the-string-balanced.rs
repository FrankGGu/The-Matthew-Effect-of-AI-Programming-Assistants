impl Solution {
    pub fn min_swaps(s: String) -> i32 {
        let mut balance = 0;
        let mut max_balance = 0;

        for c in s.chars() {
            if c == '[' {
                balance += 1;
            } else {
                balance -= 1;
            }
            max_balance = max_balance.max(-balance);
        }

        (max_balance + 1) / 2
    }
}