import java.util.*;

public class Solution {
    public long maximumSum(int[][] edges) {
        int n = edges.length + 1;
        long[] maxEdge = new long[n];
        long[] sum = new long[n];

        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            maxEdge[u] = Math.max(maxEdge[u], (long) w);
            maxEdge[v] = Math.max(maxEdge[v], (long) w);
            sum[u] += w;
            sum[v] += w;
        }

        long maxSum = 0;
        for (int i = 0; i < n; i++) {
            maxSum = Math.max(maxSum, sum[i] - maxEdge[i] + maxEdge[i]);
        }

        return maxSum;
    }
}