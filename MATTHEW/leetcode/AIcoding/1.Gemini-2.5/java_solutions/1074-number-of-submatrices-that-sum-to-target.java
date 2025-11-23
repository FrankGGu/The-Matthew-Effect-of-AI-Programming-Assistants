import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numSubmatrixSumTarget(int[][] matrix, int target) {
        int rows = matrix.length;
        int cols = matrix[0].length;
        int count = 0;

        for (int r1 = 0; r1 < rows; r1++) {
            int[] colSums = new int[cols];
            for (int r2 = r1; r2 < rows; r2++) {
                for (int c = 0; c < cols; c++) {
                    colSums[c] += matrix[r2][c];
                }
                count += subarraySum(colSums, target);
            }
        }

        return count;
    }

    private int subarraySum(int[] nums, int target) {
        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, 1);
        int currentSum = 0;
        int count = 0;

        for (int num : nums) {
            currentSum += num;
            count += map.getOrDefault(currentSum - target, 0);
            map.put(currentSum, map.getOrDefault(currentSum, 0) + 1);
        }
        return count;
    }
}