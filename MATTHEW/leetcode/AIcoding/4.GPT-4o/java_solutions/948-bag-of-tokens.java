import java.util.Arrays;

public class Solution {
    public int bagOfTokensScore(int[] tokens, int P) {
        Arrays.sort(tokens);
        int score = 0, maxScore = 0, left = 0, right = tokens.length - 1;

        while (left <= right) {
            if (P >= tokens[left]) {
                P -= tokens[left++];
                score++;
                maxScore = Math.max(maxScore, score);
            } else if (score > 0) {
                P += tokens[right--];
                score--;
            } else {
                break;
            }
        }
        return maxScore;
    }
}