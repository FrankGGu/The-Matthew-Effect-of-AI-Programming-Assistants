impl Solution {
    pub fn xor_beauty(arr: Vec<i32>) -> i32 {
        let mut result = 0;
        for &num in &arr {
            result ^= num;
        }
        result
    }
}