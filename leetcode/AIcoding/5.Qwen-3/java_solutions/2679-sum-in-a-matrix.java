public class Solution {
    public int matrixSum(int[][] nums) {
        for (int[] row : nums) {
            java.util.Arrays.sort(row);
        }
        int maxSum = 0;
        for (int j = 0; j < nums[0].length; j++) {
            int maxVal = 0;
            for (int i = 0; i < nums.length; i++) {
                maxVal = Math.max(maxVal, nums[i][j]);
            }
            maxSum += maxVal;
        }
        return maxSum;
    }
}