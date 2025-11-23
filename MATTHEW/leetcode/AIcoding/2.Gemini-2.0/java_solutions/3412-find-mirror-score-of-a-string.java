class Solution {
    public int findMirrorScore(String s) {
        int n = s.length();
        int score = 0;
        for (int len = 1; len <= n; len++) {
            String prefix = s.substring(0, len);
            String suffix = s.substring(n - len);
            if (prefix.equals(new StringBuilder(suffix).reverse().toString())) {
                score = len * len;
            }
        }
        return score;
    }
}