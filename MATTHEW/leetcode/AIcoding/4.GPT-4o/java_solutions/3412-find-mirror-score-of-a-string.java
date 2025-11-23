class Solution {
    public int mirrorScore(String s) {
        int score = 0;
        int n = s.length();
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == s.charAt(n - 1 - i)) {
                score += 1;
            }
        }
        return score;
    }
}