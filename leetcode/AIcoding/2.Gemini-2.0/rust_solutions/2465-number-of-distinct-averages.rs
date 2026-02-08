impl Solution {
    pub fn distinct_averages(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut seen = std::collections::HashSet::new();
        let mut l = 0;
        let mut r = nums.len() - 1;
        while l < r {
            let avg = (nums[l] + nums[r]) as f64 / 2.0;
            seen.insert(avg);
            l += 1;
            r -= 1;
        }
        seen.len() as i32
    }
}