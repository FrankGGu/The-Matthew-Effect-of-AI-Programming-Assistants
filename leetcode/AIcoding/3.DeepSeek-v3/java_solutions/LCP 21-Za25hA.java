import java.util.*;

class Solution {
    public int chaseGame(int[][] edges, int startA, int startB) {
        int n = edges.length;
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph.computeIfAbsent(u, k -> new ArrayList<>()).add(v);
            graph.computeIfAbsent(v, k -> new ArrayList<>()).add(u);
        }

        int[] distA = new int[n + 1];
        int[] distB = new int[n + 1];
        Arrays.fill(distA, -1);
        Arrays.fill(distB, -1);
        bfs(graph, startA, distA);
        bfs(graph, startB, distB);

        int cycleLength = findCycleLength(graph, n);
        int maxDist = 0;
        for (int i = 1; i <= n; i++) {
            if (distA[i] > distB[i] + 1) {
                if (cycleLength > 3) {
                    return -1;
                } else {
                    maxDist = Math.max(maxDist, distA[i]);
                }
            }
        }
        return maxDist;
    }

    private void bfs(Map<Integer, List<Integer>> graph, int start, int[] dist) {
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(start);
        dist[start] = 0;
        while (!queue.isEmpty()) {
            int u = queue.poll();
            for (int v : graph.getOrDefault(u, new ArrayList<>())) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    queue.offer(v);
                }
            }
        }
    }

    private int findCycleLength(Map<Integer, List<Integer>> graph, int n) {
        int[] parent = new int[n + 1];
        Arrays.fill(parent, -1);
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(1);
        parent[1] = 0;
        int cycleNode = -1;
        while (!queue.isEmpty()) {
            int u = queue.poll();
            for (int v : graph.getOrDefault(u, new ArrayList<>())) {
                if (parent[v] == -1) {
                    parent[v] = u;
                    queue.offer(v);
                } else if (v != parent[u]) {
                    cycleNode = u;
                }
            }
        }
        if (cycleNode == -1) {
            return 0;
        }
        int length = 1;
        int current = cycleNode;
        while (parent[current] != cycleNode) {
            current = parent[current];
            length++;
        }
        return length;
    }
}