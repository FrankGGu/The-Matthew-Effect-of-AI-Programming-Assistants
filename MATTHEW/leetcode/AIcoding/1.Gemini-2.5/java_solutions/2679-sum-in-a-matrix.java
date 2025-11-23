import java.util.Arrays;

class Solution {
    public int matrixSum(int[][] nums) {
        int m = nums.length;
        int n = nums[0].length;

        for (int i = 0; i < m; i++) {
            Arrays.sort(nums[i]);
        }

        int totalSum = 0;

        for (int j = 0; j < n; j++) {
            int maxOfCurrentLargestInRows = 0;
            for (int i = 0; i < m; i++) {
                maxOfCurrentLargestInRows = Math.max(maxOfCurrentLargestInRows, nums[i][n - 1 - j]);
            }
            totalSum += maxOfCurrentLargestInRows;
        }

        return totalSum;
    }
}