impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut res = 0;
        let mut flip = 0;
        for i in 0..nums.len() {
            let num = nums[i] ^ flip;
            if num == 0 {
                res += 1;
                flip ^= 1;
            }
        }
        res
    }
}