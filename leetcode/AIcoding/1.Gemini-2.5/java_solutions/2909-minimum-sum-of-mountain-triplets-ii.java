import java.util.Arrays;

class Solution {
    public int minimumSum(int[] nums) {
        int n = nums.length;

        // leftMin[j] stores the minimum value in nums[0...j-1]
        // Initialize with Integer.MAX_VALUE for the first element as there's nothing to its left
        int[] leftMin = new int[n];
        leftMin[0] = Integer.MAX_VALUE; 
        for (int i = 1; i < n; i++) {
            leftMin[i] = Math.min(leftMin[i - 1], nums[i - 1]);
        }

        // rightMin[j] stores the minimum value in nums[j+1...n-1]
        // Initialize with Integer.MAX_VALUE for the last element as there's nothing to its right
        int[] rightMin = new int[n];
        rightMin[n - 1] = Integer.MAX_VALUE;
        for (int i = n - 2; i >= 0; i--) {
            rightMin[i] = Math.min(rightMin[i + 1], nums[i + 1]);
        }

        long minMountainSum = Long.MAX_VALUE;

        // Iterate through all possible middle elements 'j'
        // 'j' must have at least one element to its left (i) and one to its right (k)
        // So, j ranges from 1 to n-2
        for (int j = 1; j < n - 1; j++) {
            // Check if nums[j] can be the peak of a mountain triplet
            // i.e., there's a smaller element to its left and a smaller element to its right
            if (leftMin[j] < nums[j] && rightMin[j] < nums[j]) {
                // If it's a mountain, calculate the sum and update minMountainSum
                long currentSum = (long)leftMin[j] + nums[j] + rightMin[j];
                minMountainSum = Math.min(minMountainSum, currentSum);
            }
        }

        // If minMountainSum is still Long.MAX_VALUE, no mountain triplet was found
        if (minMountainSum == Long.MAX_VALUE) {
            return -1;
        } else {
            // Otherwise, return the minimum sum found.
            // The problem specifies an 'int' return type, implying the result will fit.
            return (int) minMountainSum;
        }
    }
}