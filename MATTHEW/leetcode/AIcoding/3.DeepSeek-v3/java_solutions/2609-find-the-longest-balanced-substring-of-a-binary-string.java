class Solution {
    public int findTheLongestBalancedSubstring(String s) {
        int maxLen = 0;
        int n = s.length();
        for (int i = 0; i < n; ) {
            if (s.charAt(i) == '0') {
                int zeroCount = 0;
                int oneCount = 0;
                while (i < n && s.charAt(i) == '0') {
                    zeroCount++;
                    i++;
                }
                while (i < n && s.charAt(i) == '1') {
                    oneCount++;
                    i++;
                }
                int balancedLen = 2 * Math.min(zeroCount, oneCount);
                if (balancedLen > maxLen) {
                    maxLen = balancedLen;
                }
            } else {
                i++;
            }
        }
        return maxLen;
    }
}