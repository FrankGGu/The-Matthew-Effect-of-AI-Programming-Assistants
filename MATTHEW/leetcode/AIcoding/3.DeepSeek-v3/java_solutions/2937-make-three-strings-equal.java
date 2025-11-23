class Solution {
    public int findMinimumOperations(String s1, String s2, String s3) {
        int minLen = Math.min(s1.length(), Math.min(s2.length(), s3.length()));
        int common = 0;
        for (int i = 0; i < minLen; i++) {
            if (s1.charAt(i) == s2.charAt(i) && s2.charAt(i) == s3.charAt(i)) {
                common++;
            } else {
                break;
            }
        }
        if (common == 0) {
            return -1;
        }
        return s1.length() + s2.length() + s3.length() - 3 * common;
    }
}