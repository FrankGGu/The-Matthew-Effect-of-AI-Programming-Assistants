class Solution {
    public int maxDivisibilityScore(int[] nums, int[] divisors) {
        int maxScore = -1;
        int resultDivisor = -1;

        for (int divisor : divisors) {
            int currentScore = 0;
            for (int num : nums) {
                if (num % divisor == 0) {
                    currentScore++;
                }
            }

            if (currentScore > maxScore) {
                maxScore = currentScore;
                resultDivisor = divisor;
            } else if (currentScore == maxScore) {
                if (resultDivisor == -1 || divisor < resultDivisor) {
                    resultDivisor = divisor;
                }
            }
        }
        return resultDivisor;
    }
}