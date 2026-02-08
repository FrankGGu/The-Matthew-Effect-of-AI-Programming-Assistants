class Solution {
    public int maxPartitionsAfterOperations(String s, int k) {
        int n = s.length();
        if (k == 26) return 1;

        int[] dp = new int[1 << 26];
        Arrays.fill(dp, -1);

        return dfs(s, 0, 0, 0, k, dp);
    }

    private int dfs(String s, int index, int mask, int changed, int k, int[] dp) {
        if (index == s.length()) {
            return 1;
        }

        int key = mask << 2 | changed;
        if (dp[key] != -1) return dp[key];

        int res = 0;
        int charIndex = s.charAt(index) - 'a';
        int newMask = mask | (1 << charIndex);

        if (Integer.bitCount(newMask) > k) {
            res = 1 + dfs(s, index + 1, 1 << charIndex, changed, k, dp);
        } else {
            res = dfs(s, index + 1, newMask, changed, k, dp);
        }

        if (changed == 0) {
            for (int c = 0; c < 26; c++) {
                if (c == charIndex) continue;
                int tempMask = mask | (1 << c);
                if (Integer.bitCount(tempMask) > k) {
                    res = Math.max(res, 1 + dfs(s, index + 1, 1 << c, 1, k, dp));
                } else {
                    res = Math.max(res, dfs(s, index + 1, tempMask, 1, k, dp));
                }
            }
        }

        dp[key] = res;
        return res;
    }
}