class Solution {
    public int numSub(String s) {
        long totalSubstrings = 0;
        long currentOnesCount = 0;
        long MOD = 1_000_000_007;

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '1') {
                currentOnesCount++;
            } else {
                // A block of '1's just ended
                // The number of substrings from a block of k ones is k * (k + 1) / 2
                totalSubstrings = (totalSubstrings + (currentOnesCount * (currentOnesCount + 1) / 2)) % MOD;
                currentOnesCount = 0; // Reset count for the next block
            }
        }

        // After the loop, if the string ends with '1's, process the last block
        totalSubstrings = (totalSubstrings + (currentOnesCount * (currentOnesCount + 1) / 2)) % MOD;

        return (int) totalSubstrings;
    }
}