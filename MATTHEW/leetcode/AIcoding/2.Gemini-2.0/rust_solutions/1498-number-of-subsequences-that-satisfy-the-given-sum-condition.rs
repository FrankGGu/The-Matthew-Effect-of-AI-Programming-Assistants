impl Solution {
    pub fn num_subseq(nums: Vec<i32>, target: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut count = 0;
        let n = nums.len();
        let mod_val = 1_000_000_007;
        let mut powers = vec![1; n];
        for i in 1..n {
            powers[i] = (powers[i - 1] * 2) % mod_val;
        }

        let mut left = 0;
        let mut right = n - 1;

        while left <= right {
            if nums[left] + nums[right] > target {
                right -= 1;
            } else {
                count = (count + powers[right - left]) % mod_val;
                left += 1;
            }
        }

        count as i32
    }
}