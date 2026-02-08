impl Solution {
    pub fn xor_beauty(nums: Vec<i32>) -> i32 {
        let mut result = 0;
        for &num in &nums {
            result ^= num;
        }
        result
    }
}