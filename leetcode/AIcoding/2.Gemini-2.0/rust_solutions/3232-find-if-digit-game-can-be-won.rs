impl Solution {
    pub fn digit_game(n: String, x: i32) -> bool {
        let len = n.len();
        if len % 2 == 0 {
            return true;
        }
        let mut sum = 0;
        let mut count = 0;
        for c in n.chars() {
            let digit = c.to_digit(10).unwrap() as i32;
            if digit % 2 != 0 {
                sum += digit;
                count += 1;
            }
        }
        if count == 0 {
            return false;
        }
        if count % 2 != 0 {
            return true;
        }

        let mut even_count = 0;
        let mut odd_count = 0;
        for c in n.chars() {
            let digit = c.to_digit(10).unwrap() as i32;
            if len % 2 == 0 {
                if digit % 2 == 0 {
                    even_count += 1;
                } else {
                    odd_count += 1;
                }
            } else {
                 if digit % 2 == 0 {
                    even_count += 1;
                } else {
                    odd_count += 1;
                }
            }

        }
        if len % 2 != 0 {
            if odd_count > even_count {
                return true;
            } else {
                return false;
            }
        } else {
            if even_count > odd_count {
                return false;
            } else {
                return true;
            }
        }
    }
}