class Solution {
    public int maxScore(int[] cardPoints, int k) {
        int n = cardPoints.length;
        int totalSum = 0;
        for (int cardPoint : cardPoints) {
            totalSum += cardPoint;
        }

        int windowSize = n - k;
        int currentSum = 0;
        for (int i = 0; i < windowSize; i++) {
            currentSum += cardPoints[i];
        }

        int minSum = currentSum;
        for (int i = windowSize; i < n; i++) {
            currentSum += cardPoints[i] - cardPoints[i - windowSize];
            minSum = Math.min(minSum, currentSum);
        }

        return totalSum - minSum;
    }
}