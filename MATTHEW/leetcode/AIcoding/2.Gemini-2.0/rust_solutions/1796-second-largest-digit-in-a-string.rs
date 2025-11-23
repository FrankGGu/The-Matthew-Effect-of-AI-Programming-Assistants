impl Solution {
    pub fn second_highest(s: String) -> i32 {
        let mut max1 = -1;
        let mut max2 = -1;

        for c in s.chars() {
            if c.is_digit(10) {
                let digit = c.to_digit(10).unwrap() as i32;
                if digit > max1 {
                    max2 = max1;
                    max1 = digit;
                } else if digit > max2 && digit != max1 {
                    max2 = digit;
                }
            }
        }

        max2
    }
}