class Solution {
    public int maximumSum(int[] arr) {
        int n = arr.length;
        if (n == 0) {
            return 0; // Or throw an exception, based on problem constraints. LeetCode usually guarantees n >= 1.
        }

        // dp0 represents the maximum subarray sum ending at current index without any deletion.
        // dp1 represents the maximum subarray sum ending at current index with exactly one deletion.
        int currentMaxNoDeletion = arr[0];
        int currentMaxOneDeletion = Integer.MIN_VALUE; // Initialize with MIN_VALUE as a deletion might not be possible or beneficial yet.

        // overallMax stores the maximum sum found so far across all possibilities (with or without deletion).
        int overallMax = arr[0];

        for (int i = 1; i < n; i++) {
            // Store previous values before updating for current index
            int prevMaxNoDeletion = currentMaxNoDeletion;
            int prevMaxOneDeletion = currentMaxOneDeletion;

            // Calculate currentMaxNoDeletion:
            // Either start a new subarray at arr[i], or extend the previous one.
            currentMaxNoDeletion = Math.max(arr[i], prevMaxNoDeletion + arr[i]);

            // Calculate currentMaxOneDeletion:
            // Option 1: Delete arr[i]. The sum is the max subarray sum ending at i-1 without deletion.
            // Option 2: Delete an element before arr[i]. The sum is prevMaxOneDeletion + arr[i].
            currentMaxOneDeletion = Math.max(prevMaxNoDeletion, prevMaxOneDeletion + arr[i]);

            // Update overallMax with the maximum of all possibilities
            overallMax = Math.max(overallMax, currentMaxNoDeletion);
            overallMax = Math.max(overallMax, currentMaxOneDeletion);
        }

        return overallMax;
    }
}