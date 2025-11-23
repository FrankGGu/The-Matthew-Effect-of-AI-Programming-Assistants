impl Solution {
    pub fn second_highest(s: String) -> i32 {
        let mut largest: i32 = -1;
        let mut second_largest: i32 = -1;

        for c in s.chars() {
            if c.is_ascii_digit() {
                let digit = c.to_digit(10).unwrap() as i32;
                if digit > largest {
                    second_largest = largest;
                    largest = digit;
                } else if digit < largest && digit > second_largest {
                    second_largest = digit;
                }
            }
        }

        second_largest
    }
}