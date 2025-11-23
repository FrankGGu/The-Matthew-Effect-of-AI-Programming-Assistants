impl Solution {
    pub fn check_zero_ones(s: String) -> bool {
        let mut max_one = 0;
        let mut max_zero = 0;
        let mut current_one = 0;
        let mut current_zero = 0;

        for c in s.chars() {
            if c == '1' {
                current_one += 1;
                current_zero = 0;
                max_one = std::cmp::max(max_one, current_one);
            } else {
                current_zero += 1;
                current_one = 0;
                max_zero = std::cmp::max(max_zero, current_zero);
            }
        }

        max_one > max_zero
    }
}