impl Solution {
    pub fn single_non_duplicate(nums: Vec<i32>) -> i32 {
        let mut low = 0;
        let mut high = nums.len() - 1;

        while low < high {
            let mut mid = low + (high - low) / 2;

            // Ensure mid is at an even index for consistent pair checking
            // If mid is odd, decrement it to make it even.
            // This simplifies the logic: we always check (mid, mid+1).
            if mid % 2 == 1 {
                mid -= 1;
            }

            // Now mid is guaranteed to be an even index.
            // Check if nums[mid] forms a pair with nums[mid+1].
            if nums[mid] == nums[mid + 1] {
                // If they are equal, it means all elements up to mid+1 are in pairs.
                // The single element must be in the right half.
                low = mid + 2;
            } else {
                // If they are not equal, it means nums[mid] or an element to its left
                // is the single non-duplicate.
                // The single element is in the left half, including mid.
                high = mid;
            }
        }

        nums[low]
    }
}