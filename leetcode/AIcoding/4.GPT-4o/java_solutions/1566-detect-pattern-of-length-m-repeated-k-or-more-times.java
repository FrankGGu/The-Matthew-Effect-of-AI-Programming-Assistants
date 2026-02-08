class Solution {
    public boolean containsPattern(String s, int m, int k) {
        int n = s.length();
        String pattern = s.substring(0, m);
        for (int i = 0; i <= n - m * k; i++) {
            boolean isPattern = true;
            for (int j = 0; j < k; j++) {
                if (!s.substring(i + j * m, i + (j + 1) * m).equals(pattern)) {
                    isPattern = false;
                    break;
                }
            }
            if (isPattern) {
                return true;
            }
        }
        return false;
    }
}