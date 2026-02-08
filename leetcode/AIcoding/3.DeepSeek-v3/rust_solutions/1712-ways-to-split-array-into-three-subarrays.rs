impl Solution {
    pub fn ways_to_split(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        let total = prefix[n];
        let mut res = 0;
        let mod_val = 1_000_000_007;

        let mut left = 1;
        let mut right = 1;

        for i in 1..n {
            left = left.max(i + 1);
            while left < n && prefix[left] - prefix[i] < prefix[i] {
                left += 1;
            }
            right = right.max(left);
            while right < n && prefix[right] - prefix[i] <= total - prefix[right] {
                right += 1;
            }
            res = (res + right - left) % mod_val;
        }
        res as i32
    }
}