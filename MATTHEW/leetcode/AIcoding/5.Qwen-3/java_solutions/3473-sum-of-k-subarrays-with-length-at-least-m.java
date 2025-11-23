public class Solution {

import java.util.*;

public class Solution {
    public long[] kSubarrays(int[] nums, int k, int m) {
        int n = nums.length;
        long[] result = new long[k];
        Arrays.fill(result, 0);

        List<int[]> intervals = new ArrayList<>();
        for (int i = 0; i <= n - m; i++) {
            intervals.add(new int[]{i, i + m - 1});
        }

        if (intervals.size() < k) {
            return result;
        }

        int total = 0;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int[] dp = new int[n + 1];
        for (int i = 0; i < n; i++) {
            dp[i + 1] = dp[i] + nums[i];
        }

        int[][] dp2 = new int[n + 1][k + 1];

        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                dp2[i][j] = Integer.MIN_VALUE;
            }
        }

        for (int i = 0; i <= n; i++) {
            dp2[i][0] = 0;
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                for (int l = 0; l < intervals.size(); l++) {
                    int start = intervals.get(l)[0];
                    int end = intervals.get(l)[1];
                    if (start <= i - m && i - m >= 0) {
                        dp2[i][j] = Math.max(dp2[i][j], dp2[start][j - 1] + (prefix[end + 1] - prefix[start]));
                    }
                }
            }
        }

        for (int i = 0; i < k; i++) {
            result[i] = dp2[n][i + 1];
        }

        return result;
    }
}
}