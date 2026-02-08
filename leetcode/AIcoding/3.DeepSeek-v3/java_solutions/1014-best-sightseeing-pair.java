class Solution {
    public int maxScoreSightseeingPair(int[] values) {
        int maxScore = 0;
        int bestPrev = values[0] + 0;

        for (int j = 1; j < values.length; j++) {
            maxScore = Math.max(maxScore, bestPrev + values[j] - j);
            bestPrev = Math.max(bestPrev, values[j] + j);
        }

        return maxScore;
    }
}