impl Solution {
    pub fn are_digits_equal(s: String) -> bool {
        let n = s.len();
        if n == 0 {
            return true;
        }
        let first_digit = s.chars().next().unwrap();
        for i in 0..n {
            if i % 2 == 0 && s.chars().nth(i).unwrap() != first_digit {
                return false;
            }
            if i % 2 != 0 && s.chars().nth(i).unwrap() == first_digit {
                return false;
            }
        }
        return true;
    }
}