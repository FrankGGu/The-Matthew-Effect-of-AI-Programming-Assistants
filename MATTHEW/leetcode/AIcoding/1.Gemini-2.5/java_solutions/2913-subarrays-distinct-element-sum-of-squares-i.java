import java.util.HashSet;
import java.util.List;

class Solution {
    public int sumOfSquares(int[] nums) {
        int n = nums.length;
        int totalSum = 0;

        for (int i = 0; i < n; i++) {
            HashSet<Integer> distinctElements = new HashSet<>();
            for (int j = i; j < n; j++) {
                distinctElements.add(nums[j]);

                int currentSubarraySumOfSquares = 0;
                for (int element : distinctElements) {
                    currentSubarraySumOfSquares += element * element;
                }
                totalSum += currentSubarraySumOfSquares;
            }
        }
        return totalSum;
    }
}