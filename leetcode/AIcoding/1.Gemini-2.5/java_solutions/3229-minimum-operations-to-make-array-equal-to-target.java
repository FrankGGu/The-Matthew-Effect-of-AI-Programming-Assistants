class Solution {
    public long minimumOperations(int[] nums, int[] target) {
        int n = nums.length;
        long totalOperations = 0;
        int currentHeight = 0; // Represents the net effect of operations that started before the current index and are still active.

        for (int i = 0; i < n; i++) {
            int neededAtI = nums[i] - target[i]; // The difference we need to make zero at index i

            if (neededAtI > currentHeight) {
                // We need to increase nums[i] (or decrease target[i]) more than what previous operations provide.
                // This implies starting new positive operations at index i.
                totalOperations += (neededAtI - currentHeight);
            } else if (neededAtI < currentHeight) {
                // We need to decrease nums[i] (or increase target[i]) more than what previous operations provide.
                // This implies starting new negative operations at index i.
                totalOperations += (currentHeight - neededAtI);
            }

            // Update currentHeight for the next iteration.
            // It now reflects the value of nums[i] - target[i] after all operations up to this point.
            currentHeight = neededAtI;
        }

        return totalOperations;
    }
}