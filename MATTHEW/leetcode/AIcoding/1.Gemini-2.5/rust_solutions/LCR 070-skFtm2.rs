impl Solution {
    pub fn single_non_duplicate(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 1 {
            return nums[0];
        }

        let mut low = 0;
        let mut high = n - 1;

        while low < high {
            let mut mid = low + (high - low) / 2;

            // Ensure mid is an even index.
            // If mid is odd, decrement it to point to the start of a potential pair.
            // This simplifies the comparison to always check (nums[mid], nums[mid+1]).
            if mid % 2 == 1 {
                mid -= 1;
            }

            // Now mid is always an even index.
            // Compare nums[mid] with nums[mid+1].
            if nums[mid] == nums[mid + 1] {
                // If nums[mid] == nums[mid+1], it means this is a regular pair.
                // The single element must be in the subarray to the right of this pair.
                // So, we update low to mid + 2.
                low = mid + 2;
            } else {
                // If nums[mid] != nums[mid+1], it means the single element is either nums[mid] itself,
                // or it's in the subarray nums[low...mid].
                // We narrow the search to the left half (including mid).
                high = mid;
            }
        }

        // When the loop terminates, low == high, and nums[low] is the single non-duplicate element.
        nums[low]
    }
}