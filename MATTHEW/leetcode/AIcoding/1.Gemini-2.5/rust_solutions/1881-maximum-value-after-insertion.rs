impl Solution {
    pub fn max_value(n: String, x: i32) -> String {
        let x_char = std::char::from_digit(x as u32, 10).unwrap();
        let mut n_chars: Vec<char> = n.chars().collect();

        let is_negative = n_chars[0] == '-';

        if is_negative {
            // For negative numbers, to maximize, we want to make the absolute value smaller.
            // This means inserting x at the first position where x is smaller than the current digit.
            // We start iterating from index 1 to skip the '-' sign.
            for i in 1..n_chars.len() {
                if x_char < n_chars[i] {
                    n_chars.insert(i, x_char);
                    return n_chars.into_iter().collect();
                }
            }
            // If x is not smaller than any digit in n (after the sign), append it to the end.
            n_chars.push(x_char);
        } else {
            // For positive numbers, to maximize, we want to make the number larger.
            // This means inserting x at the first position where x is greater than the current digit.
            // We start iterating from index 0.
            for i in 0..n_chars.len() {
                if x_char > n_chars[i] {
                    n_chars.insert(i, x_char);
                    return n_chars.into_iter().collect();
                }
            }
            // If x is not greater than any digit in n, append it to the end.
            n_chars.push(x_char);
        }

        n_chars.into_iter().collect()
    }
}