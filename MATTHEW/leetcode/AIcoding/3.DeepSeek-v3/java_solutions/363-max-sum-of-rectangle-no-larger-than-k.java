import java.util.TreeSet;

class Solution {
    public int maxSumSubmatrix(int[][] matrix, int k) {
        int rows = matrix.length;
        int cols = matrix[0].length;
        int max = Integer.MIN_VALUE;

        for (int left = 0; left < cols; left++) {
            int[] rowSum = new int[rows];
            for (int right = left; right < cols; right++) {
                for (int i = 0; i < rows; i++) {
                    rowSum[i] += matrix[i][right];
                }
                TreeSet<Integer> set = new TreeSet<>();
                set.add(0);
                int currSum = 0;
                for (int sum : rowSum) {
                    currSum += sum;
                    Integer num = set.ceiling(currSum - k);
                    if (num != null) {
                        max = Math.max(max, currSum - num);
                    }
                    set.add(currSum);
                }
            }
        }
        return max;
    }
}