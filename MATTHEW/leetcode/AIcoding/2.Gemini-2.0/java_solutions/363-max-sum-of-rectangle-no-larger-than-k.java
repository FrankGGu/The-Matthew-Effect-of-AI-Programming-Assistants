import java.util.TreeSet;

class Solution {
    public int maxSumSubmatrix(int[][] matrix, int k) {
        int rows = matrix.length;
        int cols = matrix[0].length;
        int maxSum = Integer.MIN_VALUE;

        for (int left = 0; left < cols; left++) {
            int[] rowSum = new int[rows];
            for (int right = left; right < cols; right++) {
                for (int i = 0; i < rows; i++) {
                    rowSum[i] += matrix[i][right];
                }

                TreeSet<Integer> set = new TreeSet<>();
                set.add(0);
                int currentSum = 0;

                for (int sum : rowSum) {
                    currentSum += sum;
                    Integer ceiling = set.ceiling(currentSum - k);
                    if (ceiling != null) {
                        maxSum = Math.max(maxSum, currentSum - ceiling);
                    }
                    set.add(currentSum);
                }
            }
        }

        return maxSum;
    }
}