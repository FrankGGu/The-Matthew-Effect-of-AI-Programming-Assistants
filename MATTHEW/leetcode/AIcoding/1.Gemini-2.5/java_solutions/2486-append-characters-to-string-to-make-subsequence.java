class Solution {
    public int appendCharacters(String s, String t) {
        int sPtr = 0;
        int tPtr = 0;
        int sLen = s.length();
        int tLen = t.length();

        while (sPtr < sLen && tPtr < tLen) {
            if (s.charAt(sPtr) == t.charAt(tPtr)) {
                tPtr++;
            }
            sPtr++;
        }

        return tLen - tPtr;
    }
}