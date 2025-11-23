import java.util.Arrays;

class Solution {
    public long minimumCost(String source, String target, char[] original, char[] changed, int[] cost) {
        int n = source.length();
        int m = original.length;
        long[][] dist = new long[26][26];
        for (int i = 0; i < 26; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
            dist[i][i] = 0;
        }
        for (int i = 0; i < m; i++) {
            dist[original[i] - 'a'][changed[i] - 'a'] = Math.min(dist[original[i] - 'a'][changed[i] - 'a'], cost[i]);
        }
        for (int k = 0; k < 26; k++) {
            for (int i = 0; i < 26; i++) {
                for (int j = 0; j < 26; j++) {
                    if (dist[i][k] != Integer.MAX_VALUE && dist[k][j] != Integer.MAX_VALUE) {
                        dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }
        long ans = 0;
        for (int i = 0; i < n; i++) {
            if (source.charAt(i) == target.charAt(i)) {
                continue;
            }
            long minCost = dist[source.charAt(i) - 'a'][target.charAt(i) - 'a'];
            if (minCost == Integer.MAX_VALUE) {
                return -1;
            }
            ans += minCost;
        }
        return ans;
    }
}