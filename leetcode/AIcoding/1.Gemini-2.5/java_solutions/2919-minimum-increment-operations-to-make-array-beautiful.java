class Solution {
    public long minimumIncrementOperations(int[] nums) {
        int n = nums.length;

        // The problem states n >= 3, so no need to handle n < 3 explicitly for problem constraints.
        // If n < 3 were possible, the cost would be 0 as no conditions apply.

        long totalCost = 0;

        // prev2 will store the modified value of nums[i-2]
        // prev1 will store the modified value of nums[i-1]
        // For i = 0 and i = 1, no conditions apply, so their values are taken as original.
        long prev2 = nums[0]; 
        long prev1 = nums[1]; 

        // Iterate from i = 2 to n-1 to apply the condition: nums[k] + nums[k+1] >= nums[k+2]
        // For the current index i, this means nums[i-2] + nums[i-1] >= nums[i]
        for (int i = 2; i < n; ++i) {
            long currentOriginalVal = nums[i];

            // The minimum value required for nums[i] to satisfy the condition
            // nums[i-2] + nums[i-1] >= nums[i]
            long requiredVal = prev2 + prev1;

            long actualCurrentVal; // The value nums[i] will take after potential modification

            if (currentOriginalVal < requiredVal) {
                // If the original value is less than required, we must increment it.
                // The cost is the difference.
                totalCost += (requiredVal - currentOriginalVal);
                actualCurrentVal = requiredVal; // nums[i] takes the minimum required value
            } else {
                // If the original value already satisfies the condition, no increment is needed.
                // We take its original value to minimize future requirements.
                actualCurrentVal = currentOriginalVal;
            }

            // Update prev2 and prev1 for the next iteration (i.e., for i+1)
            // The value that was prev1 now becomes prev2
            // The value that was actualCurrentVal (for nums[i]) now becomes prev1
            prev2 = prev1;
            prev1 = actualCurrentVal;
        }

        return totalCost;
    }
}