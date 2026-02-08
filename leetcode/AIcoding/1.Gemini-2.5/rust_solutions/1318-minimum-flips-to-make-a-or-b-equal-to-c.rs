impl Solution {
    pub fn min_flips(mut a: i32, mut b: i32, mut c: i32) -> i32 {
        let mut flips = 0;

        let mut ua = a as u32;
        let mut ub = b as u32;
        let mut uc = c as u32;

        while ua > 0 || ub > 0 || uc > 0 {
            let bit_a = ua & 1;
            let bit_b = ub & 1;
            let bit_c = uc & 1;

            if bit_c == 0 {
                // If the target bit is 0, both corresponding bits in a and b must be 0.
                // Count flips for each bit that is 1.
                if bit_a == 1 {
                    flips += 1;
                }
                if bit_b == 1 {
                    flips += 1;
                }
            } else { // bit_c == 1
                // If the target bit is 1, at least one of the corresponding bits in a or b must be 1.
                // If both are 0, we need one flip to make one of them 1.
                if bit_a == 0 && bit_b == 0 {
                    flips += 1;
                }
            }

            ua >>= 1;
            ub >>= 1;
            uc >>= 1;
        }

        flips
    }
}