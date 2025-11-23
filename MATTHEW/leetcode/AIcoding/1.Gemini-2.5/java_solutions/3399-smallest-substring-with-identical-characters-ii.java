class Solution {
    public int smallestSubstring(String s, int k) {
        int minLen = Integer.MAX_VALUE;
        int n = s.length();

        if (n == 0) {
            return -1; 
        }

        int currentRunLength = 0;

        for (int i = 0; i < n; i++) {
            if (i == 0 || s.charAt(i) == s.charAt(i - 1)) {
                currentRunLength++;
            } else {
                if (currentRunLength >= k) {
                    minLen = Math.min(minLen, currentRunLength);
                }
                currentRunLength = 1;
            }
        }

        if (currentRunLength >= k) {
            minLen = Math.min(minLen, currentRunLength);
        }

        return minLen == Integer.MAX_VALUE ? -1 : minLen;
    }
}