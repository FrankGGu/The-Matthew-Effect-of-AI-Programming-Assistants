public class Solution {

import java.util.*;

public class Solution {
    public String shortestSuperstring(String[] A) {
        int n = A.length;
        int[][] dist = new int[n][n];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    dist[i][j] = getDistance(A[i], A[j]);
                }
            }
        }

        int[][] dp = new int[1 << n][n];
        int[][] prev = new int[1 << n][n];

        for (int[] row : dp) {
            Arrays.fill(row, -1);
        }

        for (int i = 0; i < n; i++) {
            dp[1 << i][i] = A[i].length();
        }

        for (int mask = 1; mask < (1 << n); mask++) {
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) == 0) continue;
                for (int j = 0; j < n; j++) {
                    if ((mask & (1 << j)) != 0) continue;
                    int nextMask = mask | (1 << j);
                    int newCost = dp[mask][i] + dist[i][j];
                    if (dp[nextMask][j] < newCost) {
                        dp[nextMask][j] = newCost;
                        prev[nextMask][j] = i;
                    }
                }
            }
        }

        int last = 0;
        int min = dp[(1 << n) - 1][0];
        for (int i = 1; i < n; i++) {
            if (dp[(1 << n) - 1][i] < min) {
                min = dp[(1 << n) - 1][i];
                last = i;
            }
        }

        int mask = (1 << n) - 1;
        List<Integer> path = new ArrayList<>();
        while (mask > 0) {
            path.add(last);
            int p = prev[mask][last];
            mask ^= (1 << last);
            last = p;
        }

        Collections.reverse(path);
        StringBuilder sb = new StringBuilder(A[path.get(0)]);
        for (int i = 1; i < path.size(); i++) {
            int a = path.get(i - 1);
            int b = path.get(i);
            sb.append(A[b].substring(A[a].length() - dist[a][b]));
        }

        return sb.toString();
    }

    private int getDistance(String s1, String s2) {
        int len = Math.min(s1.length(), s2.length());
        for (int i = len; i > 0; i--) {
            if (s1.endsWith(s2.substring(0, i))) {
                return i;
            }
        }
        return 0;
    }
}
}