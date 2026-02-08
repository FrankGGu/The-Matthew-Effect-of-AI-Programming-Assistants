class Solution {
    public int distinctSubseqII(String s) {
        int MOD = 1_000_000_007;

        int[] last = new int[26];

        int totalDistinctSubsequences = 0;

        for (char c : s.toCharArray()) {
            int charIdx = c - 'a';

            int newCountForChar = (totalDistinctSubsequences + 1) % MOD;

            totalDistinctSubsequences = (2 * totalDistinctSubsequences + 1 - last[charIdx]) % MOD;

            totalDistinctSubsequences = (totalDistinctSubsequences + MOD) % MOD;

            last[charIdx] = newCountForChar;
        }

        return totalDistinctSubsequences;
    }
}