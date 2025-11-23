impl Solution {
    pub fn minimum_sum(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left_min = vec![i32::MAX; n];
        let mut right_min = vec![i32::MAX; n];

        let mut current_min = nums[0];
        left_min[0] = nums[0];
        for i in 1..n {
            current_min = current_min.min(nums[i]);
            left_min[i] = current_min;
        }

        current_min = nums[n - 1];
        right_min[n - 1] = nums[n - 1];
        for i in (0..n - 1).rev() {
            current_min = current_min.min(nums[i]);
            right_min[i] = current_min;
        }

        let mut min_sum = i32::MAX;
        for i in 1..n - 1 {
            if nums[i] > left_min[i - 1] && nums[i] > right_min[i + 1] {
                min_sum = min_sum.min(left_min[i - 1] + nums[i] + right_min[i + 1]);
            }
        }

        if min_sum == i32::MAX {
            return -1;
        } else {
            return min_sum;
        }
    }
}