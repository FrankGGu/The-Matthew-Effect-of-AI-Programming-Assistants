class Solution {
    public int maxPower(String s) {
        int maxLen = 0;
        int currentLen = 0;
        char currentChar = ' ';

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == currentChar) {
                currentLen++;
            } else {
                currentChar = s.charAt(i);
                currentLen = 1;
            }
            maxLen = Math.max(maxLen, currentLen);
        }

        return maxLen;
    }
}