class Solution {
    public int maxScore(int[] cardPoints, int k) {
        int totalSum = 0;
        for (int point : cardPoints) {
            totalSum += point;
        }

        if (k == cardPoints.length) {
            return totalSum;
        }

        int windowSize = cardPoints.length - k;
        int windowSum = 0;
        for (int i = 0; i < windowSize; i++) {
            windowSum += cardPoints[i];
        }

        int minWindowSum = windowSum;
        for (int i = windowSize; i < cardPoints.length; i++) {
            windowSum += cardPoints[i] - cardPoints[i - windowSize];
            minWindowSum = Math.min(minWindowSum, windowSum);
        }

        return totalSum - minWindowSum;
    }
}