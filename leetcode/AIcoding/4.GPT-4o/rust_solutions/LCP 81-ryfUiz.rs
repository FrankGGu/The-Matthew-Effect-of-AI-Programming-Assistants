impl Solution {
    pub fn maximum_xor(nums: Vec<i32>) -> i32 {
        let mut result = 0;
        for num in nums {
            result |= num;
        }
        result
    }
}