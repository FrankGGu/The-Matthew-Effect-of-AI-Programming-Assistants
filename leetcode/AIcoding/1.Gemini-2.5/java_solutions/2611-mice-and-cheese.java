import java.util.Arrays;

class Solution {
    public int miceAndCheese(int[] reward1, int[] reward2, int k) {
        int n = reward1.length;
        int[] diffs = new int[n];
        int totalScore = 0;

        for (int i = 0; i < n; i++) {
            diffs[i] = reward1[i] - reward2[i];
            totalScore += reward2[i];
        }

        Arrays.sort(diffs);

        for (int i = 0; i < k; i++) {
            totalScore += diffs[n - 1 - i];
        }

        return totalScore;
    }
}