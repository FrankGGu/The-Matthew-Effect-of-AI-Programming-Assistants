import java.util.Arrays;
import java.util.List;

class Solution {
    public int matrixSum(int[][] nums) {
        int m = nums.length;
        int n = nums[0].length;
        int sum = 0;

        for (int i = 0; i < m; i++) {
            Arrays.sort(nums[i]);
        }

        for (int j = 0; j < n; j++) {
            int maxVal = 0;
            for (int i = 0; i < m; i++) {
                maxVal = Math.max(maxVal, nums[i][j]);
            }
            sum += maxVal;
        }

        return sum;
    }
}