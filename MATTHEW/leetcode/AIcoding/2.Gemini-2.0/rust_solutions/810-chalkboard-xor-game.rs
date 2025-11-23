impl Solution {
    pub fn xor_game(nums: Vec<i32>) -> bool {
        if nums.len() % 2 == 0 {
            return true;
        }

        let mut xor_sum = 0;
        for &num in &nums {
            xor_sum ^= num;
        }

        xor_sum == 0
    }
}