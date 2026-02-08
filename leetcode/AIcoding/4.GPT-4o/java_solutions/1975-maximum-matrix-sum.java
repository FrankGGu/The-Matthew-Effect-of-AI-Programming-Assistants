class Solution {
    public int maximumMatrixSum(int[][] matrix) {
        long sum = 0;
        int minAbs = Integer.MAX_VALUE;
        int negativeCount = 0;

        for (int[] row : matrix) {
            for (int value : row) {
                if (value < 0) {
                    negativeCount++;
                }
                sum += Math.abs(value);
                minAbs = Math.min(minAbs, Math.abs(value));
            }
        }

        if (negativeCount % 2 == 0) {
            return (int) sum;
        } else {
            return (int) (sum - 2 * minAbs);
        }
    }
}