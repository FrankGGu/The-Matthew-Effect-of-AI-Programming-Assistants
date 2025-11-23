import java.util.HashMap;

public class Solution {
    public int numSubmatrixSumTarget(int[][] matrix, int target) {
        int m = matrix.length, n = matrix[0].length;
        int count = 0;

        for (int left = 0; left < n; left++) {
            int[] rowSum = new int[m];
            for (int right = left; right < n; right++) {
                for (int i = 0; i < m; i++) {
                    rowSum[i] += matrix[i][right];
                }
                count += subarraySum(rowSum, target);
            }
        }
        return count;
    }

    private int subarraySum(int[] arr, int target) {
        HashMap<Integer, Integer> sumCount = new HashMap<>();
        sumCount.put(0, 1);
        int count = 0, sum = 0;

        for (int num : arr) {
            sum += num;
            count += sumCount.getOrDefault(sum - target, 0);
            sumCount.put(sum, sumCount.getOrDefault(sum, 0) + 1);
        }
        return count;
    }
}