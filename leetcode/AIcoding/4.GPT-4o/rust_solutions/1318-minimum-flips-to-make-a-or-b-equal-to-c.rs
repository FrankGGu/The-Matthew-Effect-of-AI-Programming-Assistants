impl Solution {
    pub fn min_flips(a: i32, b: i32, c: i32) -> i32 {
        let mut flips = 0;
        for i in 0..32 {
            let bit_a = (a >> i) & 1;
            let bit_b = (b >> i) & 1;
            let bit_c = (c >> i) & 1;

            if bit_c == 1 {
                if bit_a == 0 && bit_b == 0 {
                    flips += 1;
                }
            } else {
                flips += bit_a + bit_b;
            }
        }
        flips
    }
}