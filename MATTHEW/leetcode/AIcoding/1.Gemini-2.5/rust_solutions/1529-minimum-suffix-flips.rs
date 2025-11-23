impl Solution {
    pub fn min_flips(target: String) -> i32 {
        let mut flips = 0;
        let mut current_bit = '0';

        for c in target.chars() {
            if c != current_bit {
                flips += 1;
                // Flip the current_bit state
                if current_bit == '0' {
                    current_bit = '1';
                } else {
                    current_bit = '0';
                }
            }
        }
        flips
    }
}