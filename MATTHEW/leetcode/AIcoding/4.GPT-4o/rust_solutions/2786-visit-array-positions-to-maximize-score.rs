impl Solution {
    pub fn max_score_indices(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut prefix_sum = vec![0; n + 1];
        let mut suffix_sum = vec![0; n + 1];

        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + (nums[i] == 0) as i32;
        }

        for i in (0..n).rev() {
            suffix_sum[i] = suffix_sum[i + 1] + (nums[i] == 1) as i32;
        }

        let mut max_score = -1;
        let mut result = Vec::new();

        for i in 0..=n {
            let score = prefix_sum[i] + suffix_sum[i];
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