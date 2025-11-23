impl Solution {
    pub fn minimize_xor(num1: i32, num2: i32) -> i32 {
        let count1 = num1.count_ones();
        let count2 = num2.count_ones();

        if count1 == count2 {
            return num1;
        }

        let mut res = 0;
        let mut bits = 31;
        let mut remaining = count2;

        if count1 > count2 {
            while remaining > 0 && bits >= 0 {
                let mask = 1 << bits;
                if (num1 & mask) != 0 {
                    res |= mask;
                    remaining -= 1;
                }
                bits -= 1;
            }
        } else {
            remaining = count2 - count1;
            res = num1;
            bits = 0;
            while remaining > 0 && bits < 32 {
                let mask = 1 << bits;
                if (num1 & mask) == 0 {
                    res |= mask;
                    remaining -= 1;
                }
                bits += 1;
            }
        }

        res
    }
}