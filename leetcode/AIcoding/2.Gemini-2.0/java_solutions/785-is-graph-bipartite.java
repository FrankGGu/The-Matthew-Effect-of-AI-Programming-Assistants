import java.util.*;

class Solution {
    public boolean isBipartite(int[][] graph) {
        int n = graph.length;
        int[] colors = new int[n];
        Arrays.fill(colors, 0);

        for (int startNode = 0; startNode < n; startNode++) {
            if (colors[startNode] == 0) {
                Queue<Integer> queue = new LinkedList<>();
                queue.offer(startNode);
                colors[startNode] = 1;

                while (!queue.isEmpty()) {
                    int u = queue.poll();

                    for (int v : graph[u]) {
                        if (colors[v] == 0) {
                            colors[v] = -colors[u];
                            queue.offer(v);
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