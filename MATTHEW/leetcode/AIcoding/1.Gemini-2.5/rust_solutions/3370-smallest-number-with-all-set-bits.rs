impl Solution {
    pub fn smallest_number_with_all_set_bits(n: i32) -> i32 {
        // The smallest number with 'n' set bits is achieved by setting the 'n' least significant bits.
        // This is equivalent to 2^n - 1.
        // For example:
        // n = 1 -> 1 (binary 1) -> 2^1 - 1 = 1
        // n = 2 -> 3 (binary 11) -> 2^2 - 1 = 3
        // n = 3 -> 7 (binary 111) -> 2^3 - 1 = 7
        // n = 0 -> 0 (binary 0) -> 2^0 - 1 = 0

        // Using `1u32` ensures the shift operation is performed on an unsigned 32-bit integer,
        // preventing potential overflow issues that can occur with `1i32 << n` when n is 31
        // (where `1i32 << 31` results in `i32::MIN`).
        // The result `u32` is then cast to `i32`.
        ((1u32 << n) - 1) as i32
    }
}