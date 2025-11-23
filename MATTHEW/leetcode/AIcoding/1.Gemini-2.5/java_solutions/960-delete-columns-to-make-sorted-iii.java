class Solution {
    public int minDeletionSize(String[] strs) {
        int M = strs.length;
        int N = strs[0].length();

        int[] dp = new int[N];

        for (int i = 0; i < N; i++) {
            dp[i] = 1;
        }

        for (int i = 0; i < N; i++) {
            for (int j = 0; j < i; j++) {
                boolean canPrecede = true;
                for (int row = 0; row < M; row++) {
                    if (strs[row].charAt(j) > strs[row].charAt(i)) {
                        canPrecede = false;
                        break;
                    }
                }

                if (canPrecede) {
                    dp[i] = Math.max(dp[i], 1 + dp[j]);
                }
            }
        }

        int maxLen = 0;
        for (int len : dp) {
            maxLen = Math.max(maxLen, len);
        }

        return N - maxLen;
    }
}