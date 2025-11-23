import java.util.Arrays;

class Solution {
    public int longestCycle(int[] edges) {
        int n = edges.length;
        int[] visited = new int[n];
        int[] path = new int[n];
        int ans = -1;

        for (int i = 0; i < n; i++) {
            if (visited[i] == 0) {
                int startNode = i;
                int pathLen = 1;
                int curr = startNode;
                Arrays.fill(path, 0);
                while (curr != -1 && visited[curr] == 0) {
                    visited[curr] = 1;
                    path[curr] = pathLen++;
                    curr = edges[curr];
                }
                if (curr != -1 && path[curr] > 0) {
                    ans = Math.max(ans, pathLen - path[curr]);
                }
            }
        }

        return ans;
    }
}