impl Solution {
    pub fn minimum_one_bit_operations(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }

        let mut k = 0;
        while (1 << k) <= n {
            k += 1;
        }

        (1 << k) - 1 - Self::minimum_one_bit_operations(n ^ (1 << (k - 1)))
    }
}