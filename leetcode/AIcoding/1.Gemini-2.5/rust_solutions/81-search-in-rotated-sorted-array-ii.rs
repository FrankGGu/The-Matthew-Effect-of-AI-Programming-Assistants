impl Solution {
    pub fn search(nums: Vec<i32>, target: i32) -> bool {
        let mut left = 0;
        let mut right = nums.len() as i32 - 1;

        while left <= right {
            let mid = left + (right - left) / 2;

            if nums[mid as usize] == target {
                return true;
            }

            // Handle duplicates: if nums[left] == nums[mid] == nums[right],
            // we cannot determine which side is sorted. Safely shrink both ends.
            if nums[left as usize] == nums[mid as usize] && nums[mid as usize] == nums[right as usize] {
                left += 1;
                right -= 1;
                continue;
            }

            // If the left half is sorted
            if nums[left as usize] <= nums[mid as usize] {
                // Check if target is within the sorted left half
                if nums[left as usize] <= target && target < nums[mid as usize] {
                    right = mid - 1;
                } else {
                    // Target is in the right half (or not present)
                    left = mid + 1;
                }
            }
            // If the right half is sorted
            else { // nums[left as usize] > nums[mid as usize]
                // Check if target is within the sorted right half
                if nums[mid as usize] < target && target <= nums[right as usize] {
                    left = mid + 1;
                } else {
                    // Target is in the left half (or not present)
                    right = mid - 1;
                }
            }
        }

        false
    }
}