impl Solution {
    pub fn can_jump(nums: Vec<i32>) -> bool {
        let mut reachable = 0;
        for i in 0..nums.len() {
            if i > reachable {
                return false;
            }
            reachable = std::cmp::max(reachable, i as i32 + nums[i]);
        }
        true
    }
}