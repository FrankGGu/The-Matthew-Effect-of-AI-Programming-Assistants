impl Solution {
    pub fn check_zero_ones(s: String) -> bool {
        let mut max_zero = 0;
        let mut max_one = 0;
        let mut current_zero = 0;
        let mut current_one = 0;

        for c in s.chars() {
            if c == '0' {
                current_zero += 1;
                current_one = 0;
                if current_zero > max_zero {
                    max_zero = current_zero;
                }
            } else {
                current_one += 1;
                current_zero = 0;
                if current_one > max_one {
                    max_one = current_one;
                }
            }
        }

        max_one > max_zero
    }
}