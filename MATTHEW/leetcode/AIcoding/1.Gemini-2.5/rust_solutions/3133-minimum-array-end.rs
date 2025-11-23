impl Solution {
    pub fn min_array_end(n: i32, x: i32) -> i32 {
        let mut ans = x;
        let mut count_to_add = n - 1;
        let mut bit_idx = 0;

        while count_to_add > 0 {
            // Check if the current bit position is NOT set in 'ans'
            if (ans & (1 << bit_idx)) == 0 {
                // If it's not set, we can set it to add a new bit
                // This effectively creates a new element in the conceptual array
                ans |= (1 << bit_idx);
                count_to_add -= 1;
            }
            bit_idx += 1;
        }

        ans
    }
}