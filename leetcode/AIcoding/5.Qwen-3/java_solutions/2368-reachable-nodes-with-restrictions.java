public class Solution {

import java.util.*;

public class Solution {
    public int reachableNodes(int[] edges, int n, int[] restricted) {
        Set<Integer> restrictedSet = new HashSet<>();
        for (int node : restricted) {
            restrictedSet.add(node);
        }

        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int i = 0; i < edges.length; i += 2) {
            int u = edges[i];
            int v = edges[i + 1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        boolean[] visited = new boolean[n];
        Queue<Integer> queue = new LinkedList<>();
        int result = 0;

        for (int i = 0; i < n; i++) {
            if (!restrictedSet.contains(i)) {
                queue.offer(i);
                visited[i] = true;
                break;
            }
        }

        while (!queue.isEmpty()) {
            int node = queue.poll();
            result++;

            for (int neighbor : graph.get(node)) {
                if (!visited[neighbor] && !restrictedSet.contains(neighbor)) {
                    visited[neighbor] = true;
                    queue.offer(neighbor);
                }
            }
        }

        return result;
    }
}
}