impl Solution {
    pub fn min_flips(a: i32, b: i32, c: i32) -> i32 {
        let mut flips = 0;
        for i in 0..32 {
            let mask = 1 << i;
            let a_bit = (a & mask) != 0;
            let b_bit = (b & mask) != 0;
            let c_bit = (c & mask) != 0;

            if c_bit {
                if !(a_bit || b_bit) {
                    flips += 1;
                }
            } else {
                if a_bit {
                    flips += 1;
                }
                if b_bit {
                    flips += 1;
                }
            }
        }
        flips
    }
}