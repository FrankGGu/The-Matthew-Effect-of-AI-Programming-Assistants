class Solution {
    public int appendCharacters(String s, String t) {
        int sLen = s.length(), tLen = t.length();
        int j = 0;

        for (int i = 0; i < sLen && j < tLen; i++) {
            if (s.charAt(i) == t.charAt(j)) {
                j++;
            }
        }

        return tLen - j;
    }
}