impl Solution {
    pub fn max_score_indices(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut left_zeros = vec![0; n + 1];
        let mut right_ones = vec![0; n + 1];

        for i in 1..=n {
            left_zeros[i] = left_zeros[i - 1] + if nums[i - 1] == 0 { 1 } else { 0 };
        }

        for i in (0..n).rev() {
            right_ones[i] = right_ones[i + 1] + if nums[i] == 1 { 1 } else { 0 };
        }

        let mut max_score = 0;
        let mut result = Vec::new();

        for i in 0..=n {
            let score = left_zeros[i] + right_ones[i];
            if score > max_score {
                max_score = score;
                result.clear();
                result.push(i as i32);
            } else if score == max_score {
                result.push(i as i32);
            }
        }

        result
    }
}