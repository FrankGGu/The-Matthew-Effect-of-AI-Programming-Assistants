impl Solution {
    pub fn find_kth_xor(arr: Vec<i32>, k: i32) -> i32 {
        let mut result = 0;
        for &num in &arr {
            result ^= num;
        }
        result ^ k
    }
}