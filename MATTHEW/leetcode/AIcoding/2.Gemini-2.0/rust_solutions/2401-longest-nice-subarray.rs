impl Solution {
    pub fn longest_nice_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut ans = 0;
        let mut l = 0;
        let mut mask = 0;
        for r in 0..n {
            while mask & nums[r] != 0 {
                mask ^= nums[l];
                l += 1;
            }
            mask |= nums[r];
            ans = ans.max((r - l + 1) as i32);
        }
        ans
    }
}