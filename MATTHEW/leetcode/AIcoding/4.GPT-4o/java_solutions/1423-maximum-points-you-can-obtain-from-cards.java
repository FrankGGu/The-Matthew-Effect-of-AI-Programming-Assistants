class Solution {
    public int maxScore(int[] cardPoints, int k) {
        int n = cardPoints.length;
        int totalSum = 0;
        for (int point : cardPoints) {
            totalSum += point;
        }

        int minSum = 0;
        for (int i = 0; i < n - k; i++) {
            minSum += cardPoints[i];
        }

        int result = totalSum - minSum;
        for (int i = n - k; i < n; i++) {
            minSum += cardPoints[i - (n - k)];
            minSum -= cardPoints[i];
            result = Math.max(result, totalSum - minSum);
        }

        return result;
    }
}