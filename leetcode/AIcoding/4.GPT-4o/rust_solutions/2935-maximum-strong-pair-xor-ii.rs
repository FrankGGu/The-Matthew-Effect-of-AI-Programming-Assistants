impl Solution {
    pub fn maximum_xor(nums: Vec<i32>) -> i32 {
        let mut max_xor = 0;
        for num in nums {
            max_xor ^= num;
        }
        max_xor
    }
}