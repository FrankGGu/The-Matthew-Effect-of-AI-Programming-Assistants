impl Solution {
    pub fn min_k_bit_flips(a: Vec<i32>, k: i32) -> i32 {
        let n = a.len();
        let k = k as usize;
        let mut flip = vec![0; n + 1];
        let mut res = 0;
        let mut flip_count = 0;

        for i in 0..n {
            flip_count ^= flip[i];
            if (a[i] ^ flip_count) == 0 {
                if i + k > n {
                    return -1;
                }
                res += 1;
                flip_count ^= 1;
                flip[i + k] ^= 1;
            }
        }
        res
    }
}