import java.util.*;

class Solution {
    public boolean isBipartite(int[][] graph) {
        int n = graph.length;
        int[] colors = new int[n]; 
        Arrays.fill(colors, 0); // 0: uncolored, 1: color A, -1: color B

        for (int i = 0; i < n; i++) {
            if (colors[i] == 0) {
                Queue<Integer> q = new LinkedList<>();
                q.offer(i);
                colors[i] = 1;

                while (!q.isEmpty()) {
                    int u = q.poll();

                    for (int v : graph[u]) {
                        if (colors[v] == 0) {
                            colors[v] = -colors[u];
                            q.offer(v);
                        } else if (colors[v] == colors[u]) {
                            return false;
                        }
                    }
                }
            }
        }
        return true;
    }
}