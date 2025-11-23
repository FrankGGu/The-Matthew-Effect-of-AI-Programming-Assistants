public class Solution {
    public int maxScore(int a, int b, int c) {
        int[] stones = {a, b, c};
        java.util.Arrays.sort(stones);
        int score = 0;
        while (stones[0] > 0 && stones[1] > 0 && stones[2] > 0) {
            stones[0]--;
            stones[1]--;
            score++;
            java.util.Arrays.sort(stones);
        }
        return score;
    }
}