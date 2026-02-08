impl Solution {
    pub fn binary_gap(n: i32) -> i32 {
        let mut last_bit = -1;
        let mut max_gap = 0;
        let mut bit_index = 0;

        let mut num = n;
        while num > 0 {
            if num & 1 == 1 {
                if last_bit != -1 {
                    max_gap = max_gap.max(bit_index - last_bit);
                }
                last_bit = bit_index;
            }
            num >>= 1;
            bit_index += 1;
        }

        max_gap
    }
}