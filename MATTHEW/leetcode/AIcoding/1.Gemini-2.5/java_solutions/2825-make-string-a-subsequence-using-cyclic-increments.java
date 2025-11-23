class Solution {
    public boolean canMakeSubsequence(String s, String t) {
        int sPtr = 0;
        int tPtr = 0;

        while (sPtr < s.length() && tPtr < t.length()) {
            char sChar = s.charAt(sPtr);
            char tChar = t.charAt(tPtr);

            if (sChar == tChar) {
                tPtr++;
            } else {
                char incrementedSChar = (char)(((sChar - 'a' + 1) % 26) + 'a');
                if (incrementedSChar == tChar) {
                    tPtr++;
                }
            }
            sPtr++;
        }

        return tPtr == t.length();
    }
}