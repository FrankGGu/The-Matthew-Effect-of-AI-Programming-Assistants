impl Solution {
    pub fn maximum_strong_pair_xor(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut nums = nums;
        nums.sort();
        let mut ans = 0;
        for i in 0..n {
            for j in i..n {
                if nums[j] - nums[i] <= nums[i] {
                    ans = ans.max(nums[i] ^ nums[j]);
                }
            }
        }
        ans
    }
}