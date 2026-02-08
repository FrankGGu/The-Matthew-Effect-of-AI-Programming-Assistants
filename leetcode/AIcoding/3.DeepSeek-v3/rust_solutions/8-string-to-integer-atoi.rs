impl Solution {
    pub fn my_atoi(s: String) -> i32 {
        let mut chars = s.chars().peekable();
        let mut sign = 1;
        let mut result = 0i64;

        // Skip whitespace
        while let Some(&c) = chars.peek() {
            if c == ' ' {
                chars.next();
            } else {
                break;
            }
        }

        // Handle sign
        if let Some(&c) = chars.peek() {
            if c == '+' || c == '-' {
                sign = if c == '-' { -1 } else { 1 };
                chars.next();
            }
        }

        // Process digits
        while let Some(&c) = chars.peek() {
            if c.is_ascii_digit() {
                let digit = c.to_digit(10).unwrap() as i64;
                result = result * 10 + digit;

                // Check for overflow
                if result * sign > i32::MAX as i64 {
                    return i32::MAX;
                } else if result * sign < i32::MIN as i64 {
                    return i32::MIN;
                }

                chars.next();
            } else {
                break;
            }
        }

        (result * sign) as i32
    }
}