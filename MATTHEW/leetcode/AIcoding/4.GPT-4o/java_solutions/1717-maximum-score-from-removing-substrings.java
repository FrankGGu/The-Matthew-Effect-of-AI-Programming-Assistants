class Solution {
    public int maximumScore(String s, int[] scores) {
        int maxScore = 0;
        int n = s.length();
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                String substring = s.substring(i, j + 1);
                int score = calculateScore(substring, scores);
                maxScore = Math.max(maxScore, score);
            }
        }
        return maxScore;
    }

    private int calculateScore(String substring, int[] scores) {
        int score = 0;
        for (char c : substring.toCharArray()) {
            score += scores[c - 'a'];
        }
        return score;
    }
}