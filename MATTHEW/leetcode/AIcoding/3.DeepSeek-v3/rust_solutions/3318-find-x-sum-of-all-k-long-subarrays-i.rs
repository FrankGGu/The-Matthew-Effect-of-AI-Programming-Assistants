impl Solution {
    pub fn get_xor_sum(arr: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut res = 0;
        for i in 0..=arr.len() - k {
            let mut xor = 0;
            for j in i..i + k {
                xor ^= arr[j];
            }
            res ^= xor;
        }
        res
    }
}