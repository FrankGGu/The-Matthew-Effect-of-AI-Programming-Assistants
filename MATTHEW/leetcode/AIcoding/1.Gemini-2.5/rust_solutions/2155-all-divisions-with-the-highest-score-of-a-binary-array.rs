impl Solution {
    pub fn max_score_indices(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut right_ones: i32 = nums.iter().sum();
        let mut left_zeros: i32 = 0;

        let mut max_score: i32 = -1;
        let mut result_indices: Vec<i32> = Vec::new();

        for i in 0..=n {
            let current_score = left_zeros + right_ones;

            if current_score > max_score {
                max_score = current_score;
                result_indices.clear();
                result_indices.push(i as i32);
            } else if current_score == max_score {
                result_indices.push(i as i32);
            }

            if i < n {
                if nums[i] == 0 {
                    left_zeros += 1;
                } else {
                    right_ones -= 1;
                }
            }
        }

        result_indices
    }
}