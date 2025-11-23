class Solution {
    public int findTheOccurrence(String s, String t) {
        int n = s.length(), m = t.length();
        int count = 0;

        for (int i = 0; i <= n - m; i++) {
            if (isAlmostEqual(s.substring(i, i + m), t)) {
                count++;
            }
        }
        return count;
    }

    private boolean isAlmostEqual(String a, String b) {
        int diffCount = 0;
        for (int i = 0; i < a.length(); i++) {
            if (a.charAt(i) != b.charAt(i)) {
                diffCount++;
            }
        }
        return diffCount <= 1;
    }
}