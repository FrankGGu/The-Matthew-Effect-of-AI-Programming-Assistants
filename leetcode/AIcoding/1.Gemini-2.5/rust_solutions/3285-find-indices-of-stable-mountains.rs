impl Solution {
    pub fn find_stable_mountains(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        if n < 3 {
            return Vec::new();
        }

        let mut has_smaller_left = vec![false; n];
        // has_smaller_left[i] is true if there exists j < i such that nums[j] < nums[i]
        // This is equivalent to nums[i] being greater than the minimum element to its left.
        let mut min_val_so_far = nums[0];
        for i in 1..n {
            has_smaller_left[i] = min_val_so_far < nums[i];
            min_val_so_far = min_val_so_far.min(nums[i]);
        }

        let mut has_smaller_right = vec![false; n];
        // has_smaller_right[i] is true if there exists j > i such that nums[i] > nums[j]
        // This is equivalent to nums[i] being greater than the minimum element to its right.
        let mut min_val_from_right_so_far = nums[n - 1];
        for i in (0..n - 1).rev() {
            has_smaller_right[i] = nums[i] > min_val_from_right_so_far;
            min_val_from_right_so_far = min_val_from_right_so_far.min(nums[i]);
        }

        let mut result = Vec::new();
        for i in 0..n {
            if has_smaller_left[i] && has_smaller_right[i] {
                result.push(i as i32);
            }
        }

        result
    }
}