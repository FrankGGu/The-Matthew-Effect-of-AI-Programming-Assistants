class Solution {
    public int singleNonDuplicate(int[] nums) {
        int low = 0;
        int high = nums.length - 1;

        while (low < high) {
            int mid = low + (high - low) / 2;

            // Ensure mid is at an even index for comparison with mid+1
            // If mid is odd, decrement it to make it even
            if (mid % 2 == 1) {
                mid--;
            }

            // If nums[mid] and nums[mid+1] are a pair, the single element is to the right
            if (nums[mid] == nums[mid + 1]) {
                low = mid + 2;
            } 
            // If nums[mid] and nums[mid+1] are not a pair, the single element is at or to the left of mid
            else {
                high = mid;
            }
        }

        return nums[low];
    }
}