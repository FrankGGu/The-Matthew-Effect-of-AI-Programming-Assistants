impl Solution {
    pub fn min_patches(nums: Vec<i32>, n: i32) -> i32 {
        let mut patches = 0;
        let mut reachable = 1;
        let mut i = 0;

        while reachable <= n {
            if i < nums.len() && nums[i] as i64 <= reachable as i64 {
                reachable += nums[i] as i64;
                i += 1;
            } else {
                reachable += reachable as i64;
                patches += 1;
            }
        }

        patches
    }
}