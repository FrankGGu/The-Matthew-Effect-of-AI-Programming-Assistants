impl Solution {
    pub fn minimize_xor(num1: i32, num2: i32) -> i32 {
        let mut bits_num2 = num2.count_ones() as i32;
        let mut result = 0;
        let mut temp = num1;

        for i in (0..32).rev() {
            if (temp >> i) & 1 == 1 {
                if bits_num2 > 0 {
                    result |= 1 << i;
                    bits_num2 -= 1;
                }
            }
        }

        if bits_num2 > 0 {
            for i in 0..32 {
                if bits_num2 > 0 && (result >> i) & 1 == 0 {
                    result |= 1 << i;
                    bits_num2 -= 1;
                }
            }
        }

        result
    }
}