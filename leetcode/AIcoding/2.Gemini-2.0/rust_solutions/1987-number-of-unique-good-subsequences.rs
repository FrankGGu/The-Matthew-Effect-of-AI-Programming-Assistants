impl Solution {
    pub fn number_of_unique_good_subsequences(binary: String) -> i32 {
        let n = binary.len();
        let mut ends_with_0 = 0;
        let mut ends_with_1 = 0;
        let mut has_zero = false;

        for c in binary.chars() {
            if c == '0' {
                ends_with_0 = (ends_with_0 + ends_with_1) % 1_000_000_007;
                has_zero = true;
            } else {
                ends_with_1 = (ends_with_0 + ends_with_1 + 1) % 1_000_000_007;
            }
        }

        let mut result = (ends_with_0 + ends_with_1) % 1_000_000_007;
        if has_zero {
            result = (result + 1) % 1_000_000_007;
        }

        result as i32
    }
}