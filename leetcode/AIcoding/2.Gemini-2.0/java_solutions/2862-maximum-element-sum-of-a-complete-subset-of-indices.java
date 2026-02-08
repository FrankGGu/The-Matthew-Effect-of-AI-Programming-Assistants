class Solution {
    public long maximumSum(List<Integer> nums) {
        int n = nums.size();
        long maxSum = 0;
        for (int i = 1; i <= n; i++) {
            long currentSum = 0;
            for (int j = 1; j * j <= i; j++) {
                if (i % j == 0) {
                    if (j * j == i) {
                        currentSum += nums.get(i - 1);
                    } else {
                        currentSum += nums.get(i - 1);
                        currentSum += nums.get(i / j - 1);
                    }
                }
            }
            maxSum = Math.max(maxSum, currentSum);
        }
        return maxSum;
    }
}