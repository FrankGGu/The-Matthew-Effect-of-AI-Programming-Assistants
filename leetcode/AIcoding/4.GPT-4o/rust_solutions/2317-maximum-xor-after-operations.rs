impl Solution {
    pub fn maximum_xor(nums: Vec<i32>, maximum_bit: i32) -> i32 {
        let mut xor_sum = 0;
        for num in nums {
            xor_sum ^= num;
        }
        (1 << maximum_bit) - 1 - xor_sum
    }
}