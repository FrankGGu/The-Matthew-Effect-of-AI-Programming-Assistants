class Solution {
    public int maxScoreSightseeingPair(int[] values) {
        int maxScore = 0;
        int maxVal = values[0] + 0;

        for (int j = 1; j < values.length; j++) {
            maxScore = Math.max(maxScore, maxVal + values[j] - j);
            maxVal = Math.max(maxVal, values[j] + j);
        }

        return maxScore;
    }
}