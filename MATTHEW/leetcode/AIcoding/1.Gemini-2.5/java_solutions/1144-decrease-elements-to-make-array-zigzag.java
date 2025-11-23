class Solution {
    public int movesToMakeZigzag(int[] nums) {
        int n = nums.length;
        if (n <= 1) {
            return 0;
        }

        // Calculate cost for the pattern where even-indexed elements are valleys
        // (i.e., nums[0] < nums[1] > nums[2] < nums[3] > ...)
        int costEvenIndexValley = calculateCost(nums, true);

        // Calculate cost for the pattern where even-indexed elements are peaks
        // (i.e., nums[0] > nums[1] < nums[2] > nums[3] < ...)
        int costEvenIndexPeak = calculateCost(nums, false);

        return Math.min(costEvenIndexValley, costEvenIndexPeak);
    }

    private int calculateCost(int[] originalNums, boolean startWithValley) {
        int cost = 0;
        int n = originalNums.length;
        // Create a copy to avoid modifying the original array for the second calculation
        int[] arr = new int[n];
        System.arraycopy(originalNums, 0, arr, 0, n);

        for (int i = 0; i < n; i++) {
            // Determine if the current element arr[i] should be a valley or a peak
            // based on the starting pattern (startWithValley) and its index parity.
            // If startWithValley is true: even indices are valleys, odd indices are peaks.
            // If startWithValley is false: even indices are peaks, odd indices are valleys.
            boolean isCurrentIndexValley = (i % 2 == 0 && startWithValley) || (i % 2 == 1 && !startWithValley);

            if (isCurrentIndexValley) {
                // If arr[i] should be a valley, it must be strictly smaller than its neighbors.
                // We need to decrease arr[i] if it's too large.
                int leftNeighborVal = (i > 0) ? arr[i-1] : Integer.MAX_VALUE;
                int rightNeighborVal = (i < n-1) ? arr[i+1] : Integer.MAX_VALUE;

                // The target maximum value for arr[i] to be a valley is min(left, right) - 1.
                // We use Integer.MAX_VALUE for non-existent neighbors to ensure min() works correctly.
                int targetMaxVal = Math.min(leftNeighborVal, rightNeighborVal) - 1;

                // If arr[i] is currently greater than its target maximum, we must decrease it.
                if (arr[i] > targetMaxVal) {
                    cost += (arr[i] - targetMaxVal);
                    arr[i] = targetMaxVal; // Update arr[i] for subsequent calculations
                }
            }
            // If arr[i] should be a peak, we do nothing to arr[i].
            // The conditions for a peak (arr[i] > arr[i-1] and arr[i] > arr[i+1])
            // are implicitly handled when its neighbors (arr[i-1] and arr[i+1]) are processed
            // as valleys. If a neighbor is too large, it will be decreased when it's its turn
            // to be a valley.
        }
        return cost;
    }
}