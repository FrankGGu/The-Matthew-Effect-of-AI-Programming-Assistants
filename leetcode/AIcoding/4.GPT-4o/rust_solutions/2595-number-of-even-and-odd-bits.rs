impl Solution {
    pub fn even_odd_bit(n: u32) -> Vec<i32> {
        let mut even_count = 0;
        let mut odd_count = 0;
        let mut bit_position = 0;

        while n > 0 {
            if n & 1 == 1 {
                if bit_position % 2 == 0 {
                    even_count += 1;
                } else {
                    odd_count += 1;
                }
            }
            n >>= 1;
            bit_position += 1;
        }

        vec![even_count, odd_count]
    }
}