impl Solution {
    pub fn min_k_bit_flips(arr: Vec<i32>, k: i32) -> i32 {
        let n = arr.len();
        let mut flips = 0;
        let mut flipped = vec![0; n + 1];
        let mut current_flip = 0;

        for i in 0..n {
            current_flip ^= flipped[i];
            if (arr[i] ^ current_flip) == 0 {
                if i + k > n {
                    return -1;
                }
                flips += 1;
                current_flip ^= 1;
                if i + k < n {
                    flipped[i + k] ^= 1;
                }
            }
        }
        flips
    }
}