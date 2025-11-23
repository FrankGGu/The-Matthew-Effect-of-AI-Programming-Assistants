import java.util.TreeSet;

public class Solution {
    public int maxSumSubmatrix(int[][] matrix, int k) {
        if (matrix.length == 0 || matrix[0].length == 0) return 0;
        int maxSum = Integer.MIN_VALUE;
        int rows = matrix.length, cols = matrix[0].length;

        for (int left = 0; left < cols; left++) {
            int[] sums = new int[rows];
            for (int right = left; right < cols; right++) {
                for (int i = 0; i < rows; i++) {
                    sums[i] += matrix[i][right];
                }
                maxSum = Math.max(maxSum, getMaxSum(sums, k));
            }
        }
        return maxSum;
    }

    private int getMaxSum(int[] sums, int k) {
        TreeSet<Integer> set = new TreeSet<>();
        set.add(0);
        int maxSum = Integer.MIN_VALUE, currSum = 0;

        for (int sum : sums) {
            currSum += sum;
            Integer target = set.ceiling(currSum - k);
            if (target != null) {
                maxSum = Math.max(maxSum, currSum - target);
            }
            set.add(currSum);
        }
        return maxSum;
    }
}