impl Solution {
    pub fn incremovable_subarray_count(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;

        for i in 0..n {
            for j in i..n {
                let mut is_valid_removal = true;

                // Check the prefix part: nums[0..i-1]
                // This loop iterates from k=0 up to i-2.
                // If i is 0 or 1, the range 0..i.saturating_sub(1) will be empty, which is correct
                // as an empty or single-element prefix is always strictly increasing.
                for k in 0..i.saturating_sub(1) {
                    if nums[k] >= nums[k + 1] {
                        is_valid_removal = false;
                        break;
                    }
                }
                if !is_valid_removal {
                    continue;
                }

                // Check the suffix part: nums[j+1..n-1]
                // This loop iterates from k=j+1 up to n-2.
                // If j is n-1 or n-2, the range (j+1)..n.saturating_sub(1) will be empty, which is correct
                // as an empty or single-element suffix is always strictly increasing.
                for k in (j + 1)..n.saturating_sub(1) {
                    if nums[k] >= nums[k + 1] {
                        is_valid_removal = false;
                        break;
                    }
                }
                if !is_valid_removal {
                    continue;
                }

                // Check the connection between the prefix and suffix
                // This applies only if both prefix and suffix are non-empty.
                if i > 0 && j < n - 1 {
                    if nums[i - 1] >= nums[j + 1] {
                        is_valid_removal = false;
                    }
                }

                if is_valid_removal {
                    count += 1;
                }
            }
        }
        count
    }
}