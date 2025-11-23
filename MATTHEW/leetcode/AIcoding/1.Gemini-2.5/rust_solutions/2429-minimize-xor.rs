impl Solution {
    pub fn minimize_xor(num1: i32, num2: i32) -> i32 {
        let mut result = 0;
        let mut set_bits_target = num2.count_ones();

        // First pass: Prioritize setting bits in `result` that are also set in `num1`,
        // starting from the most significant bit. This minimizes the XOR sum by making
        // those bit positions contribute 0 to the XOR.
        for i in (0..31).rev() {
            if set_bits_target == 0 {
                break;
            }
            if ((num1 >> i) & 1) == 1 {
                result |= (1 << i);
                set_bits_target -= 1;
            }
        }

        // Second pass: If `set_bits_target` is still greater than 0, it means we need
        // to set more bits in `result`. To minimize the XOR sum, we should set the
        // least significant available bits that are not already set in `result`
        // (and thus are 0 in `num1` at those positions, contributing 1 to XOR).
        if set_bits_target > 0 {
            for i in 0..31 {
                if set_bits_target == 0 {
                    break;
                }
                if ((result >> i) & 1) == 0 { // If bit i is not already set in result
                    result |= (1 << i);
                    set_bits_target -= 1;
                }
            }
        }

        result
    }
}