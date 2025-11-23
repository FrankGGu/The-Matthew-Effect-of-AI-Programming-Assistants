struct Solution;

impl Solution {
    pub fn max_score(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut score = vec![0; n];

        for i in 0..n {
            let a = nums[i];
            let left = (i + 1) as i32;
            let right = (n - i) as i32;

            if a < i as i32 {
                score[0] += 1;
                score[(i - a) as usize] -= 1;
            } else {
                score[0] += 1;
                score[n as usize] -= 1;
            }
        }

        let mut max_score = 0;
        let mut current_score = 0;

        for i in 0..n {
            current_score += score[i];
            max_score = std::cmp::max(max_score, current_score);
        }

        max_score
    }
}