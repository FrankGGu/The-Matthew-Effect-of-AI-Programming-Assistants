class Solution {
    public long zeroArray(int[] nums, int k) {
        int n = nums.length;
        long totalOperations = 0;
        long currentActiveDecrement = 0;
        long[] operationsStartedAt = new long[n]; // Stores how many operations start at index j.

        for (int i = 0; i < n; i++) {
            // Remove the effect of operations that started at index i - k,
            // as they no longer affect the current index i.
            if (i >= k) {
                currentActiveDecrement -= operationsStartedAt[i - k];
            }

            // Calculate the current value of nums[i] after applying all
            // operations that started within the active window [i-k+1, i-1].
            long currentValueAfterActiveOps = nums[i] - currentActiveDecrement;

            if (currentValueAfterActiveOps > 0) {
                // If the value is still positive, we must start new operations at index i.
                // The number of operations needed is exactly currentValueAfterActiveOps
                // to make nums[i] zero.
                operationsStartedAt[i] = currentValueAfterActiveOps;
                totalOperations += currentValueAfterActiveOps;
                // Add the effect of these new operations to the current active decrement.
                currentActiveDecrement += currentValueAfterActiveOps;
            }
        }

        return totalOperations;
    }
}