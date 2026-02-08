import java.util.Arrays;

class Solution {
    public int reductionOperations(int[] nums) {
        Arrays.sort(nums);

        int operations = 0;
        int currentReductionCost = 0; // Represents how many distinct values are strictly smaller than the current element's value.

        for (int i = 1; i < nums.length; i++) {
            if (nums[i] > nums[i - 1]) {
                // If the current element is strictly greater than the previous one,
                // it means we've encountered a new, larger distinct value.
                // This new distinct value requires one more "level" of reduction
                // compared to the previous distinct value.
                currentReductionCost++;
            }
            // Each element at nums[i] needs 'currentReductionCost' operations
            // to eventually be reduced to the smallest value in the array.
            operations += currentReductionCost;
        }

        return operations;
    }
}