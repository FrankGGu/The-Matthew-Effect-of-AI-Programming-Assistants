import java.util.Arrays;
import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public boolean isBipartite(int[][] graph) {
        int n = graph.length;
        int[] colors = new int[n]; // 0: uncolored, 1: color A, -1: color B
        Arrays.fill(colors, 0);

        for (int i = 0; i < n; i++) {
            if (colors[i] == 0) { // If node i is uncolored, start BFS from here
                Queue<Integer> q = new LinkedList<>();
                q.offer(i);
                colors[i] = 1; // Assign initial color (e.g., color A)

                while (!q.isEmpty()) {
                    int u = q.poll();

                    for (int v : graph[u]) {
                        if (colors[v] == 0) { // If neighbor v is uncolored
                            colors[v] = -colors[u]; // Assign the opposite color
                            q.offer(v);
                        } else if (colors[v] == colors[u]) { // If neighbor v has the same color as u
                            return false; // Not bipartite, conflict found
                        }
                    }
                }
            }
        }
        return true; // All nodes colored without conflicts, graph is bipartite
    }
}