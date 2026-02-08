class Solution {
    public int singleNonDuplicate(int[] nums) {
        int low = 0;
        int high = nums.length - 1;

        while (low < high) {
            int mid = low + (high - low) / 2;

            // Ensure mid is at an even index for comparison with mid+1
            // If mid is odd, decrement it to make it even.
            // This way, we always compare nums[even_idx] with nums[even_idx + 1].
            if (mid % 2 == 1) {
                mid--;
            }

            // If nums[mid] == nums[mid+1], it means the pair is found
            // and all elements before mid are in pairs.
            // The single element must be to the right of mid+1.
            if (nums[mid] == nums[mid + 1]) {
                low = mid + 2;
            } else {
                // If nums[mid] != nums[mid+1], it means the pattern is broken.
                // The single element is at or to the left of mid.
                high = mid;
            }
        }

        // When the loop terminates, low == high, and this index points to the single element.
        return nums[low];
    }
}