use std::cmp::min;

impl Solution {
    pub fn min_sum_difference(nums: Vec<i32>) -> i32 {
        let n = nums.len() / 2;
        let total_sum: i32 = nums.iter().sum();

        let left_half = &nums[0..n];
        let right_half = &nums[n..2 * n];

        let mut left_sums: Vec<Vec<i32>> = vec![vec![]; n + 1];
        let mut right_sums: Vec<Vec<i32>> = vec![vec![]; n + 1];

        Self::generate_sums(0, 0, 0, left_half, &mut left_sums);
        Self::generate_sums(0, 0, 0, right_half, &mut right_sums);

        for i in 0..=n {
            right_sums[i].sort_unstable();
        }

        let mut min_diff = i32::MAX;

        for k in 0..=n {
            let target_k_right = n - k;

            if left_sums[k].is_empty() || right_sums[target_k_right].is_empty() {
                continue;
            }

            for &sum_l in &left_sums[k] {
                let target_r_val = (total_sum - 2 * sum_l) / 2;

                let r_vec = &right_sums[target_k_right];

                let idx = r_vec.partition_point(|&x| x < target_r_val);

                if idx < r_vec.len() {
                    let sum_r = r_vec[idx];
                    let current_s1 = sum_l + sum_r;
                    min_diff = min(min_diff, (total_sum - 2 * current_s1).abs());
                }
                if idx > 0 {
                    let sum_r = r_vec[idx - 1];
                    let current_s1 = sum_l + sum_r;
                    min_diff = min(min_diff, (total_sum - 2 * current_s1).abs());
                }
            }
        }

        min_diff
    }

    fn generate_sums(
        idx: usize,
        count: usize,
        current_sum: i32,
        arr: &[i32],
        sums_by_count: &mut Vec<Vec<i32>>,
    ) {
        if idx == arr.len() {
            sums_by_count[count].push(current_sum);
            return;
        }

        Self::generate_sums(idx + 1, count, current_sum, arr, sums_by_count);

        Self::generate_sums(idx + 1, count + 1, current_sum + arr[idx], arr, sums_by_count);
    }
}