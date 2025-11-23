class Solution {
    public long maxMatrixSum(int[][] matrix) {
        long totalAbsSum = 0;
        int negCount = 0;
        int minAbsVal = Integer.MAX_VALUE;

        for (int[] row : matrix) {
            for (int val : row) {
                if (val < 0) {
                    negCount++;
                }
                totalAbsSum += Math.abs(val);
                minAbsVal = Math.min(minAbsVal, Math.abs(val));
            }
        }

        if (negCount % 2 == 0) {
            return totalAbsSum;
        } else {
            return totalAbsSum - 2 * minAbsVal;
        }
    }
}