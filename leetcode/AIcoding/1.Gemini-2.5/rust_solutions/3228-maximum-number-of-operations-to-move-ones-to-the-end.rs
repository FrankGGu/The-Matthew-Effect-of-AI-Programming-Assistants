impl Solution {
    pub fn max_operations(s: String) -> i32 {
        let mut current_ones: i32 = 0;
        let mut total_operations: i32 = 0;

        for c in s.chars() {
            if c == '1' {
                current_ones += 1;
            } else { // c == '0'
                if current_ones > 0 {
                    total_operations += current_ones;
                }
            }
        }

        total_operations
    }
}