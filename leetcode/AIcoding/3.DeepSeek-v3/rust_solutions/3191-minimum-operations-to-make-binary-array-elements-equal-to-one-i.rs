impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut operations = 0;
        let mut flip = 0;

        for i in 0..nums.len() {
            let current = nums[i] ^ flip;
            if current == 0 {
                operations += 1;
                flip ^= 1;
            }
        }

        operations
    }
}