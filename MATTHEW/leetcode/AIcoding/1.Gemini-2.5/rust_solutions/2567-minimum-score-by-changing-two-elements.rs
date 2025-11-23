impl Solution {
    pub fn min_score(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let n = nums.len();

        let score1 = nums[n - 3] - nums[0];
        let score2 = nums[n - 1] - nums[2];
        let score3 = nums[n - 2] - nums[1];

        score1.min(score2).min(score3)
    }
}