import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

class Solution {
    public List<List<Integer>> getAncestors(int n, int[][] edges) {
        List<List<Integer>> revAdj = new ArrayList<>(n);
        for (int i = 0; i < n; i++) {
            revAdj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            // In the reversed graph, an edge from v to u means u is an ancestor of v
            revAdj.get(v).add(u);
        }

        List<List<Integer>> ancestors = new ArrayList<>(n);
        for (int i = 0; i < n; i++) {
            ancestors.add(new ArrayList<>());
        }

        for (int i = 0; i < n; i++) {
            Queue<Integer> queue = new LinkedList<>();
            boolean[] visited = new boolean[n];

            queue.offer(i);
            visited[i] = true;

            while (!queue.isEmpty()) {
                int curr = queue.poll();

                for (int neighbor : revAdj.get(curr)) {
                    if (!visited[neighbor]) {
                        visited[neighbor] = true;
                        queue.offer(neighbor);
                        ancestors.get(i).add(neighbor);
                    }
                }
            }
            Collections.sort(ancestors.get(i));
        }

        return ancestors;
    }
}