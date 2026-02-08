class Solution {
    public boolean isSubsequence(String s, String t) {
        int sLen = s.length(), tLen = t.length();
        int sIndex = 0, tIndex = 0;

        while (sIndex < sLen && tIndex < tLen) {
            if (s.charAt(sIndex) == t.charAt(tIndex)) {
                sIndex++;
            }
            tIndex++;
        }

        return sIndex == sLen;
    }
}