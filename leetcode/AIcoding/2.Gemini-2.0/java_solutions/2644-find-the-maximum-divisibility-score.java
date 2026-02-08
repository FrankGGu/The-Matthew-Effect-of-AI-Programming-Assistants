import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxDivScore(int[] nums, int[] divisors) {
        Map<Integer, Integer> scoreMap = new HashMap<>();
        int maxScore = 0;
        int result = divisors[0];

        for (int divisor : divisors) {
            int score = 0;
            for (int num : nums) {
                if (num % divisor == 0) {
                    score++;
                }
            }
            scoreMap.put(divisor, score);
            if (score > maxScore) {
                maxScore = score;
                result = divisor;
            } else if (score == maxScore) {
                result = Math.min(result, divisor);
            }
        }
        return result;
    }
}