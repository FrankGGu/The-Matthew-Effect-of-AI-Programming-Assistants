impl Solution {
    pub fn maximum_xor_product(a: i32, b: i32, n: i32) -> i32 {
        let modulo: u64 = 1_000_000_007;
        let mut val_a: u64 = 0;
        let mut val_b: u64 = 0;

        // Iterate from most significant bit (n-1) down to 0 for the 'n' bits where x can be non-zero.
        for i in (0..n).rev() {
            let bit_a = (a >> i) & 1;
            let bit_b = (b >> i) & 1;

            if bit_a == bit_b {
                // If a_i and b_i are the same, we want to set x_i such that
                // (a_i XOR x_i) and (b_i XOR x_i) are both 1.
                // This means x_i should be 1 - a_i.
                // This choice makes both numbers grow as large as possible at this bit position.
                val_a = (val_a << 1) | 1;
                val_b = (val_b << 1) | 1;
            } else {
                // If a_i and b_i are different, one is 0 and the other is 1.
                // We can choose x_i to make (A_i, B_i) either (0,1) or (1,0).
                // To maximize the product, we want to keep val_a and val_b as close as possible.
                // If val_a is currently less than or equal to val_b, we try to make val_a larger
                // and val_b smaller at this bit position to reduce their difference.
                // This means we want A_i = 1 and B_i = 0.
                // This is achieved by setting x_i = 1 - a_i.
                if val_a <= val_b {
                    val_a = (val_a << 1) | 1; // A_i becomes 1
                    val_b = (val_b << 1) | 0; // B_i becomes 0
                } else {
                    // If val_a is currently greater than val_b, we try to make val_b larger
                    // and val_a smaller at this bit position to reduce their difference.
                    // This means we want A_i = 0 and B_i = 1.
                    // This is achieved by setting x_i = 1 - b_i.
                    val_a = (val_a << 1) | 0; // A_i becomes 0
                    val_b = (val_b << 1) | 1; // B_i becomes 1
                }
            }
        }

        // For bits higher than n (i.e., i >= n), x_i must be 0 because 0 <= x < 2^n.
        // Therefore, for i >= n, (a XOR x)_i = a_i and (b XOR x)_i = b_i.
        // We need to incorporate these higher bits of a and b into our `val_a` and `val_b`.
        // The mask `!((1_u64 << n) - 1)` isolates bits from position `n` upwards.
        let higher_bits_mask = !((1_u64 << n) - 1);

        // Apply the higher bits of 'a' and 'b' (which are unaffected by x) to val_a and val_b.
        val_a |= (a as u64) & higher_bits_mask;
        val_b |= (b as u64) & higher_bits_mask;

        // Calculate the final product modulo 10^9 + 7.
        ((val_a % modulo) * (val_b % modulo) % modulo) as i32
    }
}