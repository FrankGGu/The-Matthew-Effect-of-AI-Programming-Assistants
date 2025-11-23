import java.util.Arrays;

public class Solution {
    public int maxScore(int[] cardPoints, int k) {
        int n = cardPoints.length;
        int totalSum = 0;
        for (int i = 0; i < k; i++) {
            totalSum += cardPoints[i];
        }
        int maxScore = totalSum;
        for (int i = 0; i < k; i++) {
            totalSum = totalSum - cardPoints[k - 1 - i] + cardPoints[n - 1 - i];
            maxScore = Math.max(maxScore, totalSum);
        }
        return maxScore;
    }
}