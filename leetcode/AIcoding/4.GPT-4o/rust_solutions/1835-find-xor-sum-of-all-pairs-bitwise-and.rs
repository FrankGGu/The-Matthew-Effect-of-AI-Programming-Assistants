impl Solution {
    pub fn xor_sum(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut total_xor = 0;
        for i in 0..32 {
            let mut count = 0;
            for &num in &arr {
                if (num >> i) & 1 == 1 {
                    count += 1;
                }
            }
            total_xor ^= (count * (n - count) * (1 << i)) as i32;
        }
        total_xor
    }
}