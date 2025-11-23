public class Solution {
    public boolean isMatch(String s, String p) {
        int sLen = s.length(), pLen = p.length();
        int sIdx = 0, pIdx = 0;
        int starIdx = -1, sBackup = 0;

        while (sIdx < sLen) {
            if (pIdx < pLen && (p.charAt(pIdx) == '?' || s.charAt(sIdx) == p.charAt(pIdx))) {
                sIdx++;
                pIdx++;
            } else if (pIdx < pLen && p.charAt(pIdx) == '*') {
                starIdx = pIdx;
                sBackup = sIdx;
                pIdx++;
            } else if (starIdx != -1) {
                pIdx = starIdx + 1;
                sIdx = sBackup + 1;
                sBackup++;
            } else {
                return false;
            }
        }

        while (pIdx < pLen && p.charAt(pIdx) == '*') {
            pIdx++;
        }

        return pIdx == pLen;
    }
}