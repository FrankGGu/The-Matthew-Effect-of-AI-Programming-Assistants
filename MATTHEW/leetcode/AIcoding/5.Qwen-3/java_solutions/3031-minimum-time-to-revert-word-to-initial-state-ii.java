public class Solution {

import java.util.*;

public class Solution {
    public int minimumTimeToRevertToInitialState(String s, int k) {
        int n = s.length();
        int[] lps = new int[n];
        for (int i = 1; i < n; i++) {
            int j = lps[i - 1];
            while (j > 0 && s.charAt(i) != s.charAt(j)) {
                j = lps[j - 1];
            }
            if (s.charAt(i) == s.charAt(j)) {
                j++;
            }
            lps[i] = j;
        }

        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            if (dp[i] == Integer.MAX_VALUE) continue;
            int j = i;
            while (j < n) {
                j += k;
                if (j > n) break;
                dp[j] = Math.min(dp[j], dp[i] + 1);
            }
        }

        return dp[n];
    }
}
}