class Solution {
    public int findTheLongestBalancedSubstring(String s) {
        int maxLen = 0;
        int numZeros = 0;
        int numOnes = 0;

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '0') {
                if (numOnes > 0) {
                    numZeros = 1;
                    numOnes = 0;
                } else {
                    numZeros++;
                }
            } else { // s.charAt(i) == '1'
                if (numZeros == 0) {
                    numZeros = 0;
                    numOnes = 0;
                } else {
                    numOnes++;
                    maxLen = Math.max(maxLen, 2 * Math.min(numZeros, numOnes));
                }
            }
        }

        return maxLen;
    }
}