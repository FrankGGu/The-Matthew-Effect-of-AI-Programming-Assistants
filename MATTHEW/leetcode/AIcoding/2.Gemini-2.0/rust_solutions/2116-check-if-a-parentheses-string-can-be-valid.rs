impl Solution {
    pub fn check_valid_string(s: String, locked: String) -> bool {
        let s: Vec<char> = s.chars().collect();
        let locked: Vec<char> = locked.chars().collect();
        let n = s.len();

        let mut low = 0;
        let mut high = 0;

        for i in 0..n {
            if locked[i] == '1' {
                if s[i] == '(' {
                    low += 1;
                    high += 1;
                } else {
                    low -= 1;
                    high -= 1;
                }
            } else {
                high += 1;
                low = std::cmp::max(low - 1, 0);
            }

            if high < 0 {
                return false;
            }
        }

        low <= 0
    }
}