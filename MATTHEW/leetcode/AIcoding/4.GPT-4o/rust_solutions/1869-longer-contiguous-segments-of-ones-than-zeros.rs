impl Solution {
    pub fn check_zero_ones(s: String) -> bool {
        let mut ones = 0;
        let mut zeros = 0;
        let mut max_ones = 0;
        let mut max_zeros = 0;

        for c in s.chars() {
            if c == '1' {
                ones += 1;
                max_zeros = max_zeros.max(zeros);
                zeros = 0;
            } else {
                zeros += 1;
                max_ones = max_ones.max(ones);
                ones = 0;
            }
        }
        max_ones = max_ones.max(ones);
        max_zeros = max_zeros.max(zeros);

        max_ones > max_zeros
    }
}