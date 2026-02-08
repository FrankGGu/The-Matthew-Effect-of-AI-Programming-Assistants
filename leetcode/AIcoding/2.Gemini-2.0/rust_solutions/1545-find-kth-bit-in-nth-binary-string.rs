impl Solution {
    pub fn find_kth_bit(n: i32, k: i32) -> char {
        if n == 1 {
            return '0';
        }
        let len = (1 << n) - 1;
        let mid = len / 2 + 1;
        if k == mid {
            return '1';
        } else if k < mid {
            return Self::find_kth_bit(n - 1, k);
        } else {
            let bit = Self::find_kth_bit(n - 1, len - k + 1);
            if bit == '0' {
                return '1';
            } else {
                return '0';
            }
        }
    }
}