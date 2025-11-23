class Solution {
    public int appendCharacters(String s, String t) {
        int sIndex = 0, tIndex = 0;
        int sLen = s.length(), tLen = t.length();

        while (sIndex < sLen && tIndex < tLen) {
            if (s.charAt(sIndex) == t.charAt(tIndex)) {
                tIndex++;
            }
            sIndex++;
        }

        return tLen - tIndex;
    }
}