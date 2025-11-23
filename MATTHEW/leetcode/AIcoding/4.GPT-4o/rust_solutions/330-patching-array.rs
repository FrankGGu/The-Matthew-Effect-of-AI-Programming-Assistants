impl Solution {
    pub fn min_patches(nums: Vec<i32>, n: i32) -> i32 {
        let mut patches = 0;
        let mut cur_max = 0;
        let mut i = 0;

        while cur_max < n {
            if i < nums.len() && nums[i] <= cur_max + 1 {
                cur_max += nums[i];
                i += 1;
            } else {
                cur_max += cur_max + 1;
                patches += 1;
            }
        }

        patches
    }
}