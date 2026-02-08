class Solution {
    public int findUnsortedSubarray(int[] nums) {
        int n = nums.length;
        if (n == 0) {
            return 0;
        }

        int minVal = Integer.MAX_VALUE;
        int maxVal = Integer.MIN_VALUE;

        // Find the rightmost boundary of the unsorted subarray
        // Iterate from left to right, keep track of the maximum element seen so far.
        // If current element is less than maxVal, it means it's out of place,
        // and this position could be the end of the unsorted subarray.
        int end = -1;
        for (int i = 0; i < n; i++) {
            if (nums[i] < maxVal) {
                end = i;
            } else {
                maxVal = nums[i];
            }
        }

        // Find the leftmost boundary of the unsorted subarray
        // Iterate from right to left, keep track of the minimum element seen so far.
        // If current element is greater than minVal, it means it's out of place,
        // and this position could be the start of the unsorted subarray.
        int start = -1;
        for (int i = n - 1; i >= 0; i--) {
            if (nums[i] > minVal) {
                start = i;
            } else {
                minVal = nums[i];
            }
        }

        if (start == -1) { // Array is already sorted
            return 0;
        } else {
            return end - start + 1;
        }
    }
}