impl Solution {
    pub fn num_subseq(nums: Vec<i32>, target: i32) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let n = nums.len();
        let mod_num = 1_000_000_007;
        let mut pow = vec![1; n + 1];
        for i in 1..=n {
            pow[i] = (pow[i - 1] * 2) % mod_num;
        }
        let mut res = 0;
        let mut left = 0;
        let mut right = n as i32 - 1;
        while left <= right {
            if nums[left as usize] + nums[right as usize] <= target {
                res = (res + pow[(right - left) as usize]) % mod_num;
                left += 1;
            } else {
                right -= 1;
            }
        }
        res
    }
}