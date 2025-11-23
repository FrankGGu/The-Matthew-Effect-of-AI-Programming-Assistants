impl Solution {
    pub fn xor_game(nums: Vec<i32>) -> bool {
        let xor = nums.iter().fold(0, |acc, &x| acc ^ x);
        xor == 0 || nums.len() % 2 == 0
    }
}