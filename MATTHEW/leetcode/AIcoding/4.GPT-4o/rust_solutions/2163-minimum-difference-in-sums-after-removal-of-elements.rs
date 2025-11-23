impl Solution {
    pub fn minimum_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len() / 2;
        let total: i32 = nums.iter().sum();
        let mut left_sums = vec![vec![0; total as usize + 1]; n + 1];
        left_sums[0][0] = 1;

        for num in &nums[..n] {
            for j in (0..n).rev() {
                for k in (0..=total).rev() {
                    if left_sums[j][k] > 0 {
                        left_sums[j + 1][k + *num as usize] += left_sums[j][k];
                    }
                }
            }
        }

        let mut right_sums = vec![vec![0; total as usize + 1]; n + 1];
        right_sums[0][0] = 1;

        for num in &nums[n..] {
            for j in (0..n).rev() {
                for k in (0..=total).rev() {
                    if right_sums[j][k] > 0 {
                        right_sums[j + 1][k + *num as usize] += right_sums[j][k];
                    }
                }
            }
        }

        let mut min_diff = i32::MAX;

        for i in 0..=n {
            for j in 0..=total {
                if left_sums[i][j] > 0 {
                    let other_sum = total - j;
                    min_diff = min_diff.min((other_sum - j).abs());
                }
            }
        }

        min_diff
    }
}