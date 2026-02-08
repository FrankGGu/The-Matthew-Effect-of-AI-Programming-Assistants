import java.util.Arrays;
import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public boolean isBipartite(int[][] graph) {
        int n = graph.length;
        int[] colors = new int[n];
        Arrays.fill(colors, 0);

        for (int i = 0; i < n; i++) {
            if (colors[i] == 0) {
                Queue<Integer> queue = new LinkedList<>();
                queue.offer(i);
                colors[i] = 1;

                while (!queue.isEmpty()) {
                    int node = queue.poll();

                    for (int neighbor : graph[node]) {
                        if (colors[neighbor] == 0) {
                            colors[neighbor] = -colors[node];
                            queue.offer(neighbor);
                        } else if (colors[neighbor] == colors[node]) {
                            return false;
                        }
                    }
                }
            }
        }

        return true;
    }
}