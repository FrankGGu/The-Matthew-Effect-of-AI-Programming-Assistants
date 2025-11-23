import java.util.*;

class Solution {
    public boolean possibleBipartition(int n, int[][] dislikes) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] dislike : dislikes) {
            int u = dislike[0];
            int v = dislike[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        int[] colors = new int[n + 1]; // 0: uncolored, 1: color A, -1: color B

        for (int i = 1; i <= n; i++) {
            if (colors[i] == 0) { // If node i is uncolored, start BFS from it
                Queue<Integer> q = new LinkedList<>();
                q.offer(i);
                colors[i] = 1; // Assign initial color A

                while (!q.isEmpty()) {
                    int u = q.poll();

                    for (int v : adj.get(u)) {
                        if (colors[v] == 0) { // If neighbor v is uncolored
                            colors[v] = -colors[u]; // Assign opposite color
                            q.offer(v);
                        } else if (colors[v] == colors[u]) { // If neighbor v has the same color
                            return false; // Not possible to bipartition
                        }
                    }
                }
            }
        }

        return true; // All components successfully bipartitioned
    }
}