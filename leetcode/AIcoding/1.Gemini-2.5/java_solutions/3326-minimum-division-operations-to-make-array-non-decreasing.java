class Solution {
    public long minimumOperations(int[] nums) {
        int n = nums.length;
        if (n <= 1) {
            return 0;
        }

        long totalOperations = 0;
        long prevVal = nums[n - 1]; // This will store the modified value of nums[i+1]

        for (int i = n - 2; i >= 0; i--) {
            long currentVal = nums[i];

            if (currentVal <= prevVal) {
                // If current element is already non-decreasing, no operations needed.
                // It becomes the new upper bound for the element to its left.
                prevVal = currentVal;
            } else {
                // currentVal > prevVal, so we need to divide currentVal.
                // We want to divide currentVal into 'numParts' such that
                // currentVal / numParts <= prevVal.
                // To minimize operations (numParts - 1), we need to minimize numParts.
                // The smallest integer numParts that satisfies currentVal / numParts <= prevVal is:
                // numParts = ceil(currentVal / prevVal)
                long numParts = (currentVal + prevVal - 1) / prevVal;

                // The number of operations is numParts - 1.
                totalOperations += (numParts - 1);

                // The new value for nums[i] will be currentVal / numParts (floor division).
                // This new value becomes the upper bound for the element to its left.
                prevVal = currentVal / numParts;
            }
        }

        return totalOperations;
    }
}