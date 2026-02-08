impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut xor_sum = 0;
        for &num in nums.iter() {
            xor_sum ^= num;
        }
        (xor_sum ^ k).count_ones() as i32
    }
}