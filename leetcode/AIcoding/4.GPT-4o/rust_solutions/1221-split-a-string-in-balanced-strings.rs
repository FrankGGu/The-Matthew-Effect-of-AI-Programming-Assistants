impl Solution {
    pub fn balanced_string_split(s: String) -> i32 {
        let mut count = 0;
        let mut balance = 0;

        for c in s.chars() {
            if c == 'L' {
                balance += 1;
            } else {
                balance -= 1;
            }
            if balance == 0 {
                count += 1;
            }
        }

        count
    }
}