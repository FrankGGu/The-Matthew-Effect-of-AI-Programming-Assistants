import java.util.*;

class Solution {
    public int minEdgeReversals(int n, int[][] edges) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            graph.get(edge[0]).add(new int[]{edge[1], 0});
            graph.get(edge[1]).add(new int[]{edge[0], 1});
        }

        return bfs(graph, n);
    }

    private int bfs(List<List<int[]>> graph, int n) {
        Queue<int[]> queue = new LinkedList<>();
        boolean[] visited = new boolean[n];
        queue.offer(new int[]{0, 0});
        visited[0] = true;
        int reversals = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] cur = queue.poll();
                int node = cur[0];
                int curReversals = cur[1];
                for (int[] neighbor : graph.get(node)) {
                    if (!visited[neighbor[0]]) {
                        visited[neighbor[0]] = true;
                        queue.offer(new int[]{neighbor[0], curReversals + neighbor[1]});
                    }
                }
            }
            if (queue.isEmpty()) break;
            reversals++;
        }

        return reversals;
    }
}