impl Solution {
    pub fn matrix_sum(nums: Vec<Vec<i32>>) -> i32 {
        let mut nums = nums;
        for row in nums.iter_mut() {
            row.sort_unstable_by(|a, b| b.cmp(a));
        }
        let mut score = 0;
        for col in 0..nums[0].len() {
            let mut max = 0;
            for row in 0..nums.len() {
                if nums[row][col] > max {
                    max = nums[row][col];
                }
            }
            score += max;
        }
        score
    }
}