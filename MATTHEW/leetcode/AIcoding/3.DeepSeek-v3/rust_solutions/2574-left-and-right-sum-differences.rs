impl Solution {
    pub fn left_right_difference(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut left_sum = vec![0; n];
        let mut right_sum = vec![0; n];

        for i in 1..n {
            left_sum[i] = left_sum[i - 1] + nums[i - 1];
        }

        for i in (0..n - 1).rev() {
            right_sum[i] = right_sum[i + 1] + nums[i + 1];
        }

        left_sum.iter().zip(right_sum.iter()).map(|(&l, &r)| (l - r).abs()).collect()
    }
}