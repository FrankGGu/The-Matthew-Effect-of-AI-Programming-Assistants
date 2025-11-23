impl Solution {
    pub fn minimize_xor(num1: i32, num2: i32) -> i32 {
        let mut count = 0;
        let mut temp = num2;

        while temp > 0 {
            count += temp & 1;
            temp >>= 1;
        }

        let mut result = 0;
        let mut bits = 0;

        for i in (0..32).rev() {
            if num1 & (1 << i) != 0 {
                bits += 1;
                result |= 1 << i;
            }
            if bits == count {
                break;
            }
        }

        for i in 0..32 {
            if bits < count && (result & (1 << i)) == 0 {
                result |= 1 << i;
                bits += 1;
            }
        }

        result
    }
}