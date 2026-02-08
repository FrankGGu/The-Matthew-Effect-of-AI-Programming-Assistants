import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minimizeTheDifference(int[][] mat, int target) {
        // Initialize a set to store all possible sums achievable so far.
        // Start with 0, representing the sum before choosing any elements from the first row.
        Set<Integer> possibleSums = new HashSet<>();
        possibleSums.add(0);

        // Iterate through each row of the matrix
        for (int[] row : mat) {
            // Create a new set to store sums achievable after processing the current row
            Set<Integer> nextPossibleSums = new HashSet<>();

            // For each sum accumulated from previous rows
            for (int prevSum : possibleSums) {
                // For each number in the current row
                for (int num : row) {
                    // Add the new sum to the set of next possible sums
                    nextPossibleSums.add(prevSum + num);
                }
            }
            // Update possibleSums to be the sums achievable after this row
            possibleSums = nextPossibleSums;
        }

        // After processing all rows, find the minimum absolute difference between any possible sum and the target
        int minDiff = Integer.MAX_VALUE;
        for (int sum : possibleSums) {
            minDiff = Math.min(minDiff, Math.abs(sum - target));
        }

        return minDiff;
    }
}