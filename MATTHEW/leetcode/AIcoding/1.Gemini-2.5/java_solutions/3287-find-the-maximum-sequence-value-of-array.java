class Solution {
    public long maximumStrength(int[] nums) {
        int n = nums.length;

        if (n < 3) {
            return 0L;
        }

        long[] minPrefix = new long[n];
        long[] maxSuffix = new long[n];
        long[] minSuffix = new long[n];

        // Calculate minPrefix array
        minPrefix[0] = nums[0];
        for (int i = 1; i < n; i++) {
            minPrefix[i] = Math.min(minPrefix[i - 1], nums[i]);
        }

        // Calculate maxSuffix and minSuffix arrays
        maxSuffix[n - 1] = nums[n - 1];
        minSuffix[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            maxSuffix[i] = Math.max(maxSuffix[i + 1], nums[i]);
            minSuffix[i] = Math.min(minSuffix[i + 1], nums[i]);
        }

        long maxSequenceValue = 0L;

        // Iterate j from 1 to n-2
        // i will be in [0, j-1]
        // k will be in [j+1, n-1]
        for (int j = 1; j < n - 1; j++) {
            // To maximize (nums[j] - nums[i]), we need to minimize nums[i] for i < j.
            // This minimum is minPrefix[j-1].
            long min_i_val = minPrefix[j - 1];

            long currentDiff = (long)nums[j] - min_i_val;

            // We want to maximize currentDiff * nums[k].
            // If currentDiff is positive, we want nums[k] to be as large as possible (maxSuffix[j+1]).
            // If currentDiff is negative, we want nums[k] to be as small as possible (minSuffix[j+1])
            // to make the product positive and large in magnitude.

            if (currentDiff >= 0) {
                maxSequenceValue = Math.max(maxSequenceValue, currentDiff * maxSuffix[j + 1]);
            } else { // currentDiff < 0
                maxSequenceValue = Math.max(maxSequenceValue, currentDiff * minSuffix[j + 1]);
            }
        }

        return maxSequenceValue;
    }
}