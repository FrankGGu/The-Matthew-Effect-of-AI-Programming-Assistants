class Solution {
    public boolean search(int[] nums, int target) {
        int low = 0;
        int high = nums.length - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2;

            if (nums[mid] == target) {
                return true;
            }

            // Handle duplicates: If nums[low] == nums[mid], we cannot determine if the left part is sorted or not.
            // In this case, we can safely increment low to eliminate the duplicate nums[low].
            // This might lead to O(N) worst-case time complexity, but it's correct.
            if (nums[low] == nums[mid]) {
                low++;
            } else if (nums[low] < nums[mid]) { // Left half is sorted
                if (target >= nums[low] && target < nums[mid]) {
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            } else { // Right half is sorted (nums[low] > nums[mid])
                if (target > nums[mid] && target <= nums[high]) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
        }
        return false;
    }
}