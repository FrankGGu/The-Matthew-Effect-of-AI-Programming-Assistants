import java.util.*;

class Solution {
    public int largestPathValue(String colors, int[][] edges) {
        int n = colors.length();
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        int[] inDegree = new int[n];
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            inDegree[v]++;
        }

        // dp[u][c] stores the maximum count of color 'c' in any path ending at node 'u'.
        int[][] dp = new int[n][26]; 

        Queue<Integer> q = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                q.offer(i);
            }
        }

        int maxColorValue = 0;
        int nodesVisited = 0;

        while (!q.isEmpty()) {
            int u = q.poll();
            nodesVisited++;

            // Increment the count for the color of the current node 'u'
            dp[u][colors.charAt(u) - 'a']++;

            // Update the overall maximum color value found so far
            for (int c = 0; c < 26; c++) {
                maxColorValue = Math.max(maxColorValue, dp[u][c]);
            }

            // Propagate DP values to neighbors
            for (int v : adj.get(u)) {
                for (int c = 0; c < 26; c++) {
                    dp[v][c] = Math.max(dp[v][c], dp[u][c]);
                }
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.offer(v);
                }
            }
        }

        // If not all nodes were visited, it means there's a cycle
        if (nodesVisited < n) {
            return -1;
        }

        return maxColorValue;
    }
}