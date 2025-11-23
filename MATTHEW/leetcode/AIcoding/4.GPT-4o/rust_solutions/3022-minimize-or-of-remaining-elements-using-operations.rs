impl Solution {
    pub fn minimize_or(nums: Vec<i32>) -> i32 {
        let mut result = 0;
        let mut max_or = 0;
        for &num in nums.iter().rev() {
            max_or |= num;
            result |= max_or;
        }
        result
    }
}