public class Solution {

import java.util.*;

public class Solution {
    public int distinctSequences(int n) {
        int MOD = 1000000007;
        if (n == 1) return 6;
        Map<Integer, Set<Integer>> graph = new HashMap<>();
        graph.put(1, new HashSet<>(Arrays.asList(2, 3, 4, 5, 6)));
        graph.put(2, new HashSet<>(Arrays.asList(1, 3, 5)));
        graph.put(3, new HashSet<>(Arrays.asList(1, 2, 4, 5)));
        graph.put(4, new HashSet<>(Arrays.asList(1, 3, 5)));
        graph.put(5, new HashSet<>(Arrays.asList(1, 2, 3, 4, 6)));
        graph.put(6, new HashSet<>(Arrays.asList(1, 5)));

        int[][] dp = new int[n + 1][7];
        for (int i = 1; i <= 6; i++) {
            dp[1][i] = 1;
        }

        for (int i = 2; i <= n; i++) {
            for (int j = 1; j <= 6; j++) {
                for (int k : graph.get(j)) {
                    dp[i][j] += dp[i - 1][k];
                    dp[i][j] %= MOD;
                }
            }
        }

        int result = 0;
        for (int i = 1; i <= 6; i++) {
            result += dp[n][i];
            result %= MOD;
        }
        return result;
    }
}
}