class Solution {
    public int countTarget(int[] scores, int target) {
        if (scores == null || scores.length == 0) {
            return 0;
        }

        // Find the index of the first element that is greater than or equal to target.
        // This effectively gives the starting index of the target occurrences.
        int firstOccurrenceIndex = binarySearch(scores, target, true);

        // Find the index of the first element that is strictly greater than target.
        // This effectively gives the index just after the last occurrence of target.
        int firstGreaterThanIndex = binarySearch(scores, target, false);

        // The number of occurrences is the difference between these two indices.
        // If target is not found, both indices will be the same (or point to the same insertion spot),
        // resulting in a count of 0.
        return firstGreaterThanIndex - firstOccurrenceIndex;
    }

    private int binarySearch(int[] nums, int target, boolean findFirst) {
        int low = 0;
        int high = nums.length - 1;
        int ans = nums.length; // Default answer if target is greater than all elements

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (findFirst) { // Search for first element >= target
                if (nums[mid] >= target) {
                    ans = mid;
                    high = mid - 1; // Try to find an even earlier occurrence
                } else {
                    low = mid + 1; // Current element is too small, search in the right half
                }
            } else { // Search for first element > target
                if (nums[mid] > target) {
                    ans = mid;
                    high = mid - 1; // Try to find an even earlier element that is > target
                } else {
                    low = mid + 1; // Current element is <= target, search in the right half
                }
            }
        }
        return ans;
    }
}