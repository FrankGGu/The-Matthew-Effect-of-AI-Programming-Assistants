impl Solution {
    pub fn count_non_decreasing_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut ans: i64 = 0;
        let mut l = 0;
        let mut max_diff = 0;

        for r in 0..n {
            max_diff = max_diff.max(nums[r]);
            while (r - l + 1) as i64 * max_diff as i64 - (nums[l..=r].iter().map(|&x| x as i64).sum::<i64>()) > k as i64 {
                l += 1;
                max_diff = 0;
                for i in l..=r {
                    max_diff = max_diff.max(nums[i]);
                }
            }
            ans += (r - l + 1) as i64;
        }

        ans
    }
}