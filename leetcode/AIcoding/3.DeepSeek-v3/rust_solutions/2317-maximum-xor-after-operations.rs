impl Solution {
    pub fn maximum_xor(nums: Vec<i32>) -> i32 {
        nums.iter().fold(0, |acc, &x| acc | x)
    }
}