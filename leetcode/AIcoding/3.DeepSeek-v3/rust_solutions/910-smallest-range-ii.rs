impl Solution {
    pub fn smallest_range_ii(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut res = nums[n - 1] - nums[0];

        for i in 0..n - 1 {
            let a = nums[i];
            let b = nums[i + 1];
            let high = (nums[n - 1] - k).max(a + k);
            let low = (nums[0] + k).min(b - k);
            res = res.min(high - low);
        }

        res
    }
}