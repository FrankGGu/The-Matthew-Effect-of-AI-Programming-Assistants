class Solution {
    public long maxMatrixSum(int[][] matrix) {
        long sum = 0;
        int minAbs = Integer.MAX_VALUE;
        int negativeCount = 0;

        for (int[] row : matrix) {
            for (int num : row) {
                if (num < 0) {
                    negativeCount++;
                }
                int absNum = Math.abs(num);
                sum += absNum;
                if (absNum < minAbs) {
                    minAbs = absNum;
                }
            }
        }

        if (negativeCount % 2 != 0) {
            sum -= 2L * minAbs;
        }

        return sum;
    }
}