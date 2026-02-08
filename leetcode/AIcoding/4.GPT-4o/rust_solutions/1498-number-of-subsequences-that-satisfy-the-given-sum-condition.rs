impl Solution {
    pub fn num_subseq(nums: Vec<i32>, target: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut pow = vec![1; n];
        for i in 1..n {
            pow[i] = pow[i - 1] * 2 % MOD;
        }
        let mut left = 0;
        let mut right = n as i32 - 1;
        let mut count = 0;
        while left <= right {
            if nums[left] + nums[right] <= target {
                count = (count + pow[(right - left) as usize]) % MOD;
                left += 1;
            } else {
                right -= 1;
            }
        }
        count
    }
}