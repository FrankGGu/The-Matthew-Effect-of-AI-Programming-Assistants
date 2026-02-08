public class Solution {
    public int getLengthOfOptimalCompression(String s, int k) {
        int n = s.length();
        int[][] dp = new int[n + 1][k + 1];

        for (int[] row : dp) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= k; j++) {
                if (dp[i][j] == Integer.MAX_VALUE) continue;
                for (int l = i; l < n; l++) {
                    int len = l - i + 1;
                    int toRemove = j + countRemovals(s, i, l);
                    if (toRemove > k) break;
                    dp[l + 1][toRemove] = Math.min(dp[l + 1][toRemove], dp[i][j] + getCompressedLength(len));
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int j = 0; j <= k; j++) {
            result = Math.min(result, dp[n][j]);
        }
        return result;
    }

    private int countRemovals(String s, int start, int end) {
        int[] count = new int[128];
        for (int i = start; i <= end; i++) {
            count[s.charAt(i)]++;
        }
        int maxCount = 0;
        for (int c : count) {
            maxCount = Math.max(maxCount, c);
        }
        return (end - start + 1) - maxCount;
    }

    private int getCompressedLength(int len) {
        if (len == 1) return 1;
        return 1 + Integer.toString(len).length();
    }
}