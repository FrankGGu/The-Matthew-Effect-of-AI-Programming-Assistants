public class Solution {
    public int maxScore(String s) {
        int totalOnes = 0;
        for (char c : s.toCharArray()) {
            if (c == '1') {
                totalOnes++;
            }
        }

        int leftOnes = 0;
        int maxScore = 0;

        for (int i = 0; i < s.length() - 1; i++) {
            if (s.charAt(i) == '1') {
                leftOnes++;
            }
            int rightOnes = totalOnes - leftOnes;
            int score = leftOnes + rightOnes;
            if (score > maxScore) {
                maxScore = score;
            }
        }

        return maxScore;
    }
}