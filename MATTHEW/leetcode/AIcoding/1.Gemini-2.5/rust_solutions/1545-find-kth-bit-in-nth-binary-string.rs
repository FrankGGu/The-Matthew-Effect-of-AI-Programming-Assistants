impl Solution {
    pub fn find_kth_bit(n: i32, k: i32) -> char {
        if n == 1 {
            return '0';
        }

        let len: i32 = (1 << n) - 1; // Length of Sn
        let mid: i32 = len / 2 + 1; // 1-indexed middle position

        if k == mid {
            return '1';
        } else if k < mid {
            // The k-th bit is in the first part, which is Sn-1
            return Self::find_kth_bit(n - 1, k);
        } else { // k > mid
            // The k-th bit is in the third part, which is reverse(invert(Sn-1))
            // Calculate the corresponding k' in Sn-1
            let k_prime = len - k + 1;
            let bit_from_sn_minus_1 = Self::find_kth_bit(n - 1, k_prime);

            // Invert the bit
            if bit_from_sn_minus_1 == '0' {
                return '1';
            } else {
                return '0';
            }
        }
    }
}