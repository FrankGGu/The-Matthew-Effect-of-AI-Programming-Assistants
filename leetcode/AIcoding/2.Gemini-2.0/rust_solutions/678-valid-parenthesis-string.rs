impl Solution {
    pub fn check_valid_string(s: String) -> bool {
        let mut low = 0;
        let mut high = 0;

        for c in s.chars() {
            match c {
                '(' => {
                    low += 1;
                    high += 1;
                }
                ')' => {
                    low -= 1;
                    high -= 1;
                }
                '*' => {
                    low -= 1;
                    high += 1;
                }
                _ => {}
            }

            low = low.max(0);

            if high < 0 {
                return false;
            }
        }

        low == 0
    }
}