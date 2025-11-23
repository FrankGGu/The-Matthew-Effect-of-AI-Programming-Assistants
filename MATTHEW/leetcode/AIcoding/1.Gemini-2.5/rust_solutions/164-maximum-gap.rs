impl Solution {
    pub fn maximum_gap(mut nums: Vec<i32>) -> i32 {
        if nums.len() < 2 {
            return 0;
        }

        nums.sort();

        let mut max_diff = 0;
        for i in 1..nums.len() {
            max_diff = max_diff.max(nums[i] - nums[i - 1]);
        }

        max_diff
    }
}