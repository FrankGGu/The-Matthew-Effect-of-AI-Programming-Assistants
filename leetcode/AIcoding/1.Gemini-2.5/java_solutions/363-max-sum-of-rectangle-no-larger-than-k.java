import java.util.TreeSet;

class Solution {
    public int maxSumSubmatrix(int[][] matrix, int k) {
        int rows = matrix.length;
        int cols = matrix[0].length;

        int maxSum = Integer.MIN_VALUE;

        for (int r1 = 0; r1 < rows; r1++) {
            int[] colSums = new int[cols];
            for (int r2 = r1; r2 < rows; r2++) {
                for (int c = 0; c < cols; c++) {
                    colSums[c] += matrix[r2][c];
                }

                int currentMaxSum1D = maxSumSubarrayNoLargerThanK(colSums, k);
                maxSum = Math.max(maxSum, currentMaxSum1D);

                if (maxSum == k) {
                    return k;
                }
            }
        }

        return maxSum;
    }

    private int maxSumSubarrayNoLargerThanK(int[] arr, int k) {
        int currentMax = Integer.MIN_VALUE;
        int currentSum = 0;
        TreeSet<Integer> prefixSums = new TreeSet<>();
        prefixSums.add(0);

        for (int num : arr) {
            currentSum += num;
            Integer ceil = prefixSums.ceiling(currentSum - k);

            if (ceil != null) {
                currentMax = Math.max(currentMax, currentSum - ceil);
            }
            prefixSums.add(currentSum);
        }
        return currentMax;
    }
}