impl Solution {
    pub fn rotated_digits(n: i32) -> i32 {
        let mut count = 0;
        for i in 1..=n {
            let mut temp = i;
            let mut has_different_digit = false;
            let mut is_invalid = false;

            while temp > 0 {
                let digit = temp % 10;
                match digit {
                    3 | 4 | 7 => {
                        is_invalid = true;
                        break;
                    }
                    2 | 5 | 6 | 9 => {
                        has_different_digit = true;
                    }
                    _ => {} // 0, 1, 8 are 'same' digits
                }
                temp /= 10;
            }

            if !is_invalid && has_different_digit {
                count += 1;
            }
        }
        count
    }
}