impl Solution {
    pub fn find_indices(nums: Vec<i32>, index_difference: i32, value_difference: i32) -> Vec<i32> {
        let n = nums.len();
        let index_diff = index_difference as usize;
        let value_diff = value_difference as i32;

        let mut min_val_idx = 0;
        let mut max_val_idx = 0;

        for j in index_diff..n {
            let i_candidate = j - index_diff;

            if nums[i_candidate] < nums[min_val_idx] {
                min_val_idx = i_candidate;
            }
            if nums[i_candidate] > nums[max_val_idx] {
                max_val_idx = i_candidate;
            }

            if (nums[j] - nums[min_val_idx]).abs() >= value_diff {
                return vec![min_val_idx as i32, j as i32];
            }
            if (nums[j] - nums[max_val_idx]).abs() >= value_diff {
                return vec![max_val_idx as i32, j as i32];
            }
        }

        vec![-1, -1]
    }
}