import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> maxScoreIndices(int[] nums) {
        int n = nums.length;
        int leftZeros = 0;
        int rightOnes = 0;

        // Calculate the initial count of ones in the entire array,
        // which represents rightOnes for division point i = 0.
        for (int x : nums) {
            if (x == 1) {
                rightOnes++;
            }
        }

        int maxScore = -1; 
        List<Integer> result = new ArrayList<>();

        // Iterate through all possible division points i from 0 to n.
        // i represents the index where the array is divided:
        // left part: nums[0...i-1]
        // right part: nums[i...n-1]
        for (int i = 0; i <= n; i++) {
            int currentScore = leftZeros + rightOnes;

            if (currentScore > maxScore) {
                maxScore = currentScore;
                result.clear(); // Found a new maximum, clear previous indices
                result.add(i);
            } else if (currentScore == maxScore) {
                result.add(i); // Add to existing list if score is equal to max
            }

            // Update leftZeros and rightOnes for the next iteration (i+1).
            // This update is only relevant if i is within the bounds of nums array.
            if (i < n) {
                if (nums[i] == 0) {
                    leftZeros++;
                } else { // nums[i] == 1
                    rightOnes--;
                }
            }
        }
        return result;
    }
}