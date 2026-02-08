impl Solution {
    pub fn minimize_sum(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let n = nums.len();
        let case1 = nums[n - 1] - nums[2];
        let case2 = nums[n - 3] - nums[0];
        let case3 = nums[n - 2] - nums[1];
        case1.min(case2).min(case3)
    }
}