impl Solution {
    pub fn minimum_damage_to_bob(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut res = 0;
        for i in (0..n).step_by(2) {
            res += nums[i];
        }
        res
    }
}