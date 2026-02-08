class Solution {
    public int kConcatenationMaxSum(int[] arr, int k) {
        long MOD = 1_000_000_007;

        // Step 1: Calculate max subarray sum for a single array, allowing empty subarray (sum 0)
        // This is a modified Kadane's algorithm.
        // It first finds the max sum for at least one element, then takes max with 0.
        long maxSoFarAtLeastOneElement = arr[0];
        long currentSumAtLeastOneElement = arr[0];
        for (int i = 1; i < arr.length; i++) {
            currentSumAtLeastOneElement = Math.max(arr[i], currentSumAtLeastOneElement + arr[i]);
            maxSoFarAtLeastOneElement = Math.max(maxSoFarAtLeastOneElement, currentSumAtLeastOneElement);
        }
        long maxSingleArrSum = Math.max(0L, maxSoFarAtLeastOneElement);

        // Step 2: Calculate total sum of the array
        long totalSum = 0;
        for (int x : arr) {
            totalSum += x;
        }

        // Step 3: Calculate maximum prefix sum, allowing empty prefix (sum 0)
        long currentPrefixSum = 0;
        long maxPrefixSum = 0;
        for (int x : arr) {
            currentPrefixSum += x;
            maxPrefixSum = Math.max(maxPrefixSum, currentPrefixSum);
        }

        // Step 4: Calculate maximum suffix sum, allowing empty suffix (sum 0)
        long currentSuffixSum = 0;
        long maxSuffixSum = 0;
        for (int i = arr.length - 1; i >= 0; i--) {
            currentSuffixSum += arr[i];
            maxSuffixSum = Math.max(maxSuffixSum, currentSuffixSum);
        }

        long ans = maxSingleArrSum;

        if (k == 1) {
            // If k is 1, the answer is simply the max subarray sum of the original array.
            // This is already stored in maxSingleArrSum.
        } else { // k > 1
            if (totalSum > 0) {
                // If total sum is positive, we can potentially benefit from including
                // (k-2) full copies of the array in the middle.
                // The max sum would be max suffix of first array + (k-2)*totalSum + max prefix of last array.
                // We also need to compare this with maxSingleArrSum (if the max sum is entirely within one array).
                long sumWithMiddleArrays = maxSuffixSum + (long)(k - 2) * totalSum + maxPrefixSum;
                ans = Math.max(ans, sumWithMiddleArrays);
            } else { // totalSum <= 0
                // If total sum is non-positive, including more full copies beyond two
                // will not increase the sum.
                // The maximum sum will be either maxSingleArrSum or max suffix of first array + max prefix of second array.
                long sumTwoArrays = maxSuffixSum + maxPrefixSum;
                ans = Math.max(ans, sumTwoArrays);
            }
        }

        return (int)(ans % MOD);
    }
}