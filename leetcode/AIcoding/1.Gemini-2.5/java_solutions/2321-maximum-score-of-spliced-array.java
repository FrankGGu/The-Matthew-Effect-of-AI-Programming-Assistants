class Solution {
    public long maximumsSplicedArray(int[] nums1, int[] nums2) {
        int n = nums1.length;

        long sum1 = 0;
        long sum2 = 0;

        // Calculate initial sums and differences for Kadane's
        int[] diff1 = new int[n]; // Represents gain/loss if we replace nums1[i] with nums2[i]
        int[] diff2 = new int[n]; // Represents gain/loss if we replace nums2[i] with nums1[i]

        for (int i = 0; i < n; i++) {
            sum1 += nums1[i];
            sum2 += nums2[i];
            diff1[i] = nums2[i] - nums1[i];
            diff2[i] = nums1[i] - nums2[i];
        }

        // Calculate maximum gain for splicing nums1 with elements from nums2
        // This means we start with sum1 and add the maximum possible sum of diff1 elements from a subarray.
        long maxGain1 = kadane(diff1);

        // Calculate maximum gain for splicing nums2 with elements from nums1
        // This means we start with sum2 and add the maximum possible sum of diff2 elements from a subarray.
        long maxGain2 = kadane(diff2);

        // The maximum score is the max of the two possible scenarios:
        // 1. Starting with nums1 and applying the best possible swaps from nums2.
        // 2. Starting with nums2 and applying the best possible swaps from nums1.
        return Math.max(sum1 + maxGain1, sum2 + maxGain2);
    }

    // Kadane's algorithm to find the maximum subarray sum.
    // This version is modified to consider an empty subarray sum (gain of 0) as a valid option,
    // which is appropriate here because we can choose not to swap any elements.
    private long kadane(int[] arr) {
        long maxCurrentGain = 0; // Maximum gain ending at the current position
        long maxOverallGain = 0; // Maximum gain found so far across all subarrays

        for (int x : arr) {
            maxCurrentGain += x;
            maxOverallGain = Math.max(maxOverallGain, maxCurrentGain);
            // If maxCurrentGain becomes negative, it means extending the current subarray
            // would decrease the sum. It's better to start a new subarray from the next element,
            // or effectively choose an empty subarray up to this point, which yields 0 gain.
            maxCurrentGain = Math.max(0, maxCurrentGain);
        }
        return maxOverallGain;
    }
}