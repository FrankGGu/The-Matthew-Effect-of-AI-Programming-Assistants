impl Solution {
    pub fn min_flips(a: i32, b: i32, c: i32) -> i32 {
        let mut flips = 0;
        for i in 0..32 {
            let a_bit = (a >> i) & 1;
            let b_bit = (b >> i) & 1;
            let c_bit = (c >> i) & 1;

            if (a_bit | b_bit) != c_bit {
                if c_bit == 0 {
                    flips += a_bit + b_bit;
                } else {
                    flips += 1;
                }
            }
        }
        flips
    }
}