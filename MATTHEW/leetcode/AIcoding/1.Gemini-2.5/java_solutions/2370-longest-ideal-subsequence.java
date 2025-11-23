class Solution {
    public int longestIdealString(String s, int k) {
        int[] dp = new int[26];
        int maxLen = 0;

        for (char ch : s.toCharArray()) {
            int currentVal = ch - 'a';
            int currentMaxEndingHere = 0;

            // Check characters from (currentVal - k) to (currentVal + k)
            // that could precede the current character in an ideal subsequence.
            int startRange = Math.max(0, currentVal - k);
            int endRange = Math.min(25, currentVal + k);

            for (int prevVal = startRange; prevVal <= endRange; prevVal++) {
                currentMaxEndingHere = Math.max(currentMaxEndingHere, dp[prevVal]);
            }

            // The length of the ideal subsequence ending with currentVal
            // is 1 (for currentVal itself) plus the maximum length found.
            dp[currentVal] = currentMaxEndingHere + 1;
            maxLen = Math.max(maxLen, dp[currentVal]);
        }

        return maxLen;
    }
}