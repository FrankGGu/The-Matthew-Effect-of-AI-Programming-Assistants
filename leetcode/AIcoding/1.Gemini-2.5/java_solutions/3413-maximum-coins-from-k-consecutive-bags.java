class Solution {
    public long maxCoins(int[] bags, int k) {
        if (bags == null || bags.length == 0 || k <= 0) {
            return 0;
        }
        if (k > bags.length) {
            return 0;
        }

        long currentSum = 0;
        for (int i = 0; i < k; i++) {
            currentSum += bags[i];
        }

        long maxSum = currentSum;

        for (int i = k; i < bags.length; i++) {
            currentSum += bags[i] - bags[i - k];
            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}