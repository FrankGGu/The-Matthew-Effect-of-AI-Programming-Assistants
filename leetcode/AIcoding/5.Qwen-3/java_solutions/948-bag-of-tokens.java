public class Solution {

import java.util.Arrays;

public class Solution {
    public int bagOfTokens(int[] tokens, int power) {
        Arrays.sort(tokens);
        int left = 0;
        int right = tokens.length - 1;
        int maxScore = 0;
        int currentScore = 0;

        while (left <= right) {
            if (tokens[left] <= power) {
                power -= tokens[left];
                left++;
                currentScore++;
                maxScore = Math.max(maxScore, currentScore);
            } else if (currentScore > 0) {
                power += tokens[right];
                right--;
                currentScore--;
            } else {
                break;
            }
        }

        return maxScore;
    }
}
}