class Solution {
    public long maximumSumOfHeights(List<Integer> maxHeights) {
        int n = maxHeights.size();
        long maxSum = 0;
        for (int i = 0; i < n; i++) {
            long currentSum = 0;
            int peak = maxHeights.get(i);
            int prev = peak;
            currentSum += peak;
            for (int j = i - 1; j >= 0; j--) {
                prev = Math.min(prev, maxHeights.get(j));
                currentSum += prev;
            }
            prev = peak;
            for (int j = i + 1; j < n; j++) {
                prev = Math.min(prev, maxHeights.get(j));
                currentSum += prev;
            }
            maxSum = Math.max(maxSum, currentSum);
        }
        return maxSum;
    }
}