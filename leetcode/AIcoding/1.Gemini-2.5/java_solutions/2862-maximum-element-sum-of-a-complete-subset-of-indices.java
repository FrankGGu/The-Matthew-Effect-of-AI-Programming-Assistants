class Solution {
    public long maximumSum(int[] nums) {
        int n = nums.length;
        long maxOverallSum = 0;

        for (int k = 1; k <= n; k++) {
            long currentSum = 0;
            for (int m = 1; ; m++) {
                long indexValue = (long) k * m * m;
                if (indexValue > n) {
                    break;
                }
                currentSum += nums[(int) indexValue - 1];
            }
            maxOverallSum = Math.max(maxOverallSum, currentSum);
        }

        return maxOverallSum;
    }
}