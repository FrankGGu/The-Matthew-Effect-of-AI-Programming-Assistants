impl Solution {
    pub fn maximum_xor_product(a: i64, b: i64, n: i64) -> i64 {
        let mut x = 0;
        let mask = (1 << n) - 1;
        let a_hi = a >> n;
        let b_hi = b >> n;
        let a_lo = a & mask;
        let b_lo = b & mask;

        for k in (0..n).rev() {
            let bit = 1 << k;
            if (a_lo ^ b_lo) & bit != 0 {
                if (a_lo & bit) != 0 && (b_lo & bit) != 0 {
                    continue;
                }
                let candidate = x | bit;
                let new_a_lo = a_lo ^ candidate;
                let new_b_lo = b_lo ^ candidate;
                let current = (a_hi << n | a_lo) * (b_hi << n | b_lo);
                let new_val = (a_hi << n | new_a_lo) * (b_hi << n | new_b_lo);
                if new_val > current {
                    x = candidate;
                }
            }
        }

        let a_xor = a ^ x;
        let b_xor = b ^ x;
        ((a_xor % 1_000_000_007) * (b_xor % 1_000_000_007)) % 1_000_000_007
    }
}