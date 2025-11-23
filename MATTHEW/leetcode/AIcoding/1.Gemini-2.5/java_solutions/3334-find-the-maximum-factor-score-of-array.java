class Solution {
    private static final int MAX_NUM = 1000000;
    private static long[] factorScores;

    static {
        // Pre-compute factor scores for all numbers up to MAX_NUM using a sieve-like approach
        factorScores = new long[MAX_NUM + 1];
        for (int i = 1; i <= MAX_NUM; i++) {
            for (int j = i; j <= MAX_NUM; j += i) {
                factorScores[j] += i;
            }
        }
    }

    public long maxFactorScore(int[] nums) {
        long maxScore = 0;
        for (int num : nums) {
            if (factorScores[num] > maxScore) {
                maxScore = factorScores[num];
            }
        }
        return maxScore;
    }
}