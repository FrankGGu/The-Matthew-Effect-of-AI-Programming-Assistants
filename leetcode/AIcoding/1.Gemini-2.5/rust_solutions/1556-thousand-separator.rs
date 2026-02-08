impl Solution {
    pub fn thousand_separator(n: i32) -> String {
        if n == 0 {
            return "0".to_string();
        }

        let s = n.to_string();
        let len = s.len();
        let mut result = String::with_capacity(len + (len - 1) / 3);

        for (i, c) in s.chars().enumerate() {
            result.push(c);
            // Insert a separator if it's not the last character
            // and the number of remaining digits (from right to left) is a multiple of 3.
            if i != len - 1 && (len - 1 - i) % 3 == 0 {
                result.push('.');
            }
        }

        result
    }
}