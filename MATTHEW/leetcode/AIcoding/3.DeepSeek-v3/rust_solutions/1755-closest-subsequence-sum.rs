impl Solution {
    pub fn min_abs_difference(nums: Vec<i32>, goal: i32) -> i32 {
        let n = nums.len();
        let half = n / 2;
        let left = &nums[..half];
        let right = &nums[half..];

        let mut left_sums = vec![0];
        for &num in left {
            let mut new_sums = Vec::new();
            for &sum in &left_sums {
                new_sums.push(sum + num);
            }
            left_sums.extend(new_sums);
        }
        left_sums.sort_unstable();

        let mut right_sums = vec![0];
        for &num in right {
            let mut new_sums = Vec::new();
            for &sum in &right_sums {
                new_sums.push(sum + num);
            }
            right_sums.extend(new_sums);
        }
        right_sums.sort_unstable();

        let mut min_diff = i32::MAX;
        for &sum in &left_sums {
            let target = goal - sum;
            let idx = right_sums.binary_search(&target).unwrap_or_else(|x| x);
            if idx < right_sums.len() {
                min_diff = min_diff.min((right_sums[idx] - target).abs());
            }
            if idx > 0 {
                min_diff = min_diff.min((right_sums[idx - 1] - target).abs());
            }
            if min_diff == 0 {
                return 0;
            }
        }
        min_diff
    }
}