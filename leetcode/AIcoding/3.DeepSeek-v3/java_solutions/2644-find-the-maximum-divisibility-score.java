class Solution {
    public int maxDivScore(int[] nums, int[] divisors) {
        int maxScore = -1;
        int result = Integer.MAX_VALUE;

        for (int d : divisors) {
            int score = 0;
            for (int num : nums) {
                if (num % d == 0) {
                    score++;
                }
            }
            if (score > maxScore) {
                maxScore = score;
                result = d;
            } else if (score == maxScore && d < result) {
                result = d;
            }
        }

        return result;
    }
}