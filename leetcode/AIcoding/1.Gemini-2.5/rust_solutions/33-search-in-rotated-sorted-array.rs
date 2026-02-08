impl Solution {
    pub fn search(nums: Vec<i32>, target: i32) -> i32 {
        if nums.is_empty() {
            return -1;
        }

        let mut left = 0;
        let mut right = nums.len() - 1;

        while left <= right {
            let mid = left + (right - left) / 2;

            if nums[mid] == target {
                return mid as i32;
            }

            // Check if the left half is sorted
            if nums[left] <= nums[mid] {
                // Target is in the left sorted half
                if target >= nums[left] && target < nums[mid] {
                    right = mid - 1;
                } else {
                    // Target is in the right unsorted half
                    left = mid + 1;
                }
            } else { // The right half must be sorted
                // Target is in the right sorted half
                if target > nums[mid] && target <= nums[right] {
                    left = mid + 1;
                } else {
                    // Target is in the left unsorted half
                    right = mid - 1;
                }
            }
        }

        -1
    }
}