import java.util.Arrays;

class Solution {
    public int maxEnvelopes(int[][] envelopes) {
        if (envelopes == null || envelopes.length == 0) {
            return 0;
        }

        Arrays.sort(envelopes, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return b[1] - a[1];
            }
        });

        int[] dp = new int[envelopes.length];
        int len = 0;

        for (int[] envelope : envelopes) {
            int h = envelope[1];
            int i = Arrays.binarySearch(dp, 0, len, h);
            if (i < 0) {
                i = -(i + 1);
            }
            if (i == len) {
                len++;
            }
            dp[i] = h;
        }

        return len;
    }
}