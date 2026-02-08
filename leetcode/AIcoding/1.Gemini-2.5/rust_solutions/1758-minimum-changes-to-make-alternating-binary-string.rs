impl Solution {
    pub fn min_operations(s: String) -> i32 {
        let mut changes_start_with_0 = 0; // Count changes needed for "0101..." pattern
        let mut changes_start_with_1 = 0; // Count changes needed for "1010..." pattern

        for (i, c) in s.chars().enumerate() {
            let current_digit = (c as u8 - b'0') as i32;

            // For pattern "0101..."
            // Expected digit at even index i is 0
            // Expected digit at odd index i is 1
            let expected_digit_start_with_0 = (i % 2) as i32;
            if current_digit != expected_digit_start_with_0 {
                changes_start_with_0 += 1;
            }

            // For pattern "1010..."
            // Expected digit at even index i is 1
            // Expected digit at odd index i is 0
            let expected_digit_start_with_1 = ((i + 1) % 2) as i32;
            if current_digit != expected_digit_start_with_1 {
                changes_start_with_1 += 1;
            }
        }

        changes_start_with_0.min(changes_start_with_1)
    }
}