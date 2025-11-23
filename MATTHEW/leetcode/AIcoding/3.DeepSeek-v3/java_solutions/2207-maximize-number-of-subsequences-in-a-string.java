class Solution {
    public long maximumSubsequenceCount(String text, String pattern) {
        char a = pattern.charAt(0);
        char b = pattern.charAt(1);
        long res = 0, cntA = 0, cntB = 0;

        for (char c : text.toCharArray()) {
            if (c == b) {
                res += cntA;
                cntB++;
            }
            if (c == a) {
                cntA++;
            }
        }

        return res + Math.max(cntA, cntB);
    }
}