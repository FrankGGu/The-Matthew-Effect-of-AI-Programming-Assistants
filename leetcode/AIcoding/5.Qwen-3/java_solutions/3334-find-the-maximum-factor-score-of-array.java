public class Solution {

import java.util.*;

public class Solution {
    public int maxFactorScore(int[] nums) {
        int maxScore = 0;
        for (int num : nums) {
            int score = 1;
            for (int i = 2; i * i <= num; i++) {
                while (num % i == 0) {
                    score *= i;
                    num /= i;
                }
            }
            if (num > 1) {
                score *= num;
            }
            maxScore = Math.max(maxScore, score);
        }
        return maxScore;
    }
}
}