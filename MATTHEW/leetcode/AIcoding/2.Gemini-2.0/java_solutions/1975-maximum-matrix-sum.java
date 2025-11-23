class Solution {
    public long maxMatrixSum(int[][] matrix) {
        long sum = 0;
        int negCount = 0;
        int minAbs = Integer.MAX_VALUE;

        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[0].length; j++) {
                int num = matrix[i][j];
                sum += Math.abs(num);
                if (num < 0) {
                    negCount++;
                }
                minAbs = Math.min(minAbs, Math.abs(num));
            }
        }

        if (negCount % 2 == 0) {
            return sum;
        } else {
            return sum - 2 * minAbs;
        }
    }
}