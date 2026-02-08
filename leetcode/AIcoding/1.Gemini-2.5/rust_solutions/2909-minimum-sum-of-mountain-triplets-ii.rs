impl Solution {
    pub fn minimum_sum(nums: Vec<i32>) -> i32 {
        let n = nums.len();

        let mut left_min = vec![0; n];
        let mut right_min = vec![0; n];

        // Populate left_min array: left_min[i] stores the minimum value from nums[0] to nums[i]
        left_min[0] = nums[0];
        for i in 1..n {
            left_min[i] = left_min[i - 1].min(nums[i]);
        }

        // Populate right_min array: right_min[i] stores the minimum value from nums[i] to nums[n-1]
        right_min[n - 1] = nums[n - 1];
        for i in (0..n - 1).rev() {
            right_min[i] = right_min[i + 1].min(nums[i]);
        }

        let mut min_sum = i32::MAX;

        // Iterate through all possible middle elements (j)
        // j must be between 1 and n-2 (exclusive of 0 and n-1)
        for j in 1..n - 1 {
            // For a mountain triplet (i, j, k) with i < j < k and nums[i] < nums[j] and nums[k] < nums[j]:
            // The smallest possible nums[i] for a given j is left_min[j-1].
            // The smallest possible nums[k] for a given j is right_min[j+1].
            let val_i = left_min[j - 1];
            let val_k = right_min[j + 1];
            let val_j = nums[j];

            if val_i < val_j && val_k < val_j {
                min_sum = min_sum.min(val_i + val_j + val_k);
            }
        }

        if min_sum == i32::MAX {
            -1
        } else {
            min_sum
        }
    }
}