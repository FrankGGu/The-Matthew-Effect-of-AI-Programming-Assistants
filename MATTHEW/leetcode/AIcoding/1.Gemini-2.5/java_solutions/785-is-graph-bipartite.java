import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public boolean isBipartite(int[][] graph) {
        int n = graph.length;
        int[] colors = new int[n]; // 0: uncolored, 1: color A, 2: color B

        for (int i = 0; i < n; i++) {
            if (colors[i] == 0) { // If node i is uncolored
                Queue<Integer> q = new LinkedList<>();
                q.offer(i);
                colors[i] = 1; // Assign color A to the starting node of this component

                while (!q.isEmpty()) {
                    int u = q.poll();

                    for (int v : graph[u]) {
                        if (colors[v] == 0) { // If neighbor v is uncolored
                            colors[v] = 3 - colors[u]; // Assign the opposite color (1 -> 2, 2 -> 1)
                            q.offer(v);
                        } else if (colors[v] == colors[u]) { // If neighbor v has the same color as u
                            return false; // Not bipartite
                        }
                    }
                }
            }
        }

        return true; // All components are bipartite
    }
}