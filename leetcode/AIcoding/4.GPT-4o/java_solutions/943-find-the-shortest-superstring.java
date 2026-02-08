import java.util.*;

public class Solution {
    public String findShortestSuperstring(String[] A) {
        int n = A.length;
        int[][] overlap = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    overlap[i][j] = findOverlap(A[i], A[j]);
                }
            }
        }

        int[][] dp = new int[1 << n][n];
        for (int[] row : dp) Arrays.fill(row, -1);
        for (int i = 0; i < n; i++) dp[1 << i][i] = i;

        for (int mask = 1; mask < (1 << n); mask++) {
            for (int u = 0; u < n; u++) {
                if ((mask & (1 << u)) == 0) continue;
                for (int v = 0; v < n; v++) {
                    if ((mask & (1 << v)) != 0) continue;
                    int nextMask = mask | (1 << v);
                    int newScore = dp[mask][u] + overlap[u][v];
                    if (dp[nextMask][v] == -1 || newScore > dp[nextMask][v]) {
                        dp[nextMask][v] = newScore;
                    }
                }
            }
        }

        int maxOverlap = -1;
        int lastIndex = -1;
        int fullMask = (1 << n) - 1;
        for (int i = 0; i < n; i++) {
            if (dp[fullMask][i] > maxOverlap) {
                maxOverlap = dp[fullMask][i];
                lastIndex = i;
            }
        }

        StringBuilder result = new StringBuilder();
        int mask = fullMask;
        while (mask > 0) {
            result.append(A[lastIndex]);
            int nextMask = mask ^ (1 << lastIndex);
            if (nextMask == 0) break;
            int maxNext = -1, nextIndex = -1;
            for (int i = 0; i < n; i++) {
                if ((nextMask & (1 << i)) != 0 && (maxNext == -1 || dp[nextMask][i] > dp[nextMask][maxNext])) {
                    maxNext = dp[nextMask][i];
                    nextIndex = i;
                }
            }
            mask = nextMask;
            lastIndex = nextIndex;
        }

        String superstring = result.reverse().toString();
        for (int i = 0; i < A.length; i++) {
            if (!superstring.contains(A[i])) {
                superstring += A[i];
            }
        }
        return superstring;
    }

    private int findOverlap(String a, String b) {
        int maxOverlap = 0;
        for (int i = 1; i <= Math.min(a.length(), b.length()); i++) {
            if (a.endsWith(b.substring(0, i))) {
                maxOverlap = i;
            }
        }
        return maxOverlap;
    }
}