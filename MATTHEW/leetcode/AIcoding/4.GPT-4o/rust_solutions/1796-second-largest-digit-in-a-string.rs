impl Solution {
    pub fn second_highest(s: String) -> i32 {
        let mut digits = vec![false; 10];

        for c in s.chars() {
            if c.is_digit(10) {
                digits[c.to_digit(10).unwrap() as usize] = true;
            }
        }

        let mut first = -1;
        let mut second = -1;

        for i in (0..10).rev() {
            if digits[i] {
                if first == -1 {
                    first = i as i32;
                } else if second == -1 {
                    second = i as i32;
                    break;
                }
            }
        }

        second
    }
}