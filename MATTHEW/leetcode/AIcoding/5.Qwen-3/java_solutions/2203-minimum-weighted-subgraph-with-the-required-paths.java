public class Solution {

import java.util.*;

public class Solution {
    public int minWeightedSubgraph(int n, int[][] edges, int[] signalSpeed, int targetPath) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph.get(u).add(new int[]{v, w});
            graph.get(v).add(new int[]{u, w});
        }

        int result = Integer.MAX_VALUE;

        for (int start = 0; start < n; start++) {
            if (signalSpeed[start] == 0) continue;
            boolean[] visited = new boolean[n];
            Queue<int[]> queue = new LinkedList<>();
            queue.add(new int[]{start, 0, 0});
            visited[start] = true;

            while (!queue.isEmpty()) {
                int[] node = queue.poll();
                int current = node[0];
                int pathLength = node[1];
                int totalWeight = node[2];

                if (pathLength == targetPath) {
                    result = Math.min(result, totalWeight);
                    continue;
                }

                for (int[] neighbor : graph.get(current)) {
                    int nextNode = neighbor[0];
                    int weight = neighbor[1];
                    if (!visited[nextNode]) {
                        visited[nextNode] = true;
                        queue.add(new int[]{nextNode, pathLength + 1, totalWeight + weight});
                    }
                }
            }
        }

        return result;
    }
}
}