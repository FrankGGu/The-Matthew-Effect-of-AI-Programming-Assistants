impl Solution {
    pub fn minimum_one_bit_operations(n: i32) -> i32 {
        let mut ans = 0;
        let mut n_val = n;
        while n_val > 0 {
            ans ^= n_val;
            n_val >>= 1;
        }
        ans
    }
}