public class Solution {

import java.util.*;

public class Solution {
    public int minimizePrice(int n, int[][] roads, int[] trip) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] road : roads) {
            graph.get(road[0]).add(road[1]);
            graph.get(road[1]).add(road[0]);
        }

        int[] parent = new int[n];
        boolean[] visited = new boolean[n];
        dfs(0, -1, graph, parent, visited);

        int[] depth = new int[n];
        dfsDepth(0, -1, graph, depth);

        int[] lca = new int[n];
        for (int i = 0; i < n; i++) {
            lca[i] = -1;
        }

        for (int i = 0; i < n; i++) {
            lca[i] = findLCA(trip[0], trip[1], parent, depth);
        }

        int res = 0;
        for (int i = 0; i < n; i++) {
            if (i == trip[0] || i == trip[1]) continue;
            if (isOnPath(i, trip[0], trip[1], parent)) {
                res += 1;
            }
        }

        return res;
    }

    private void dfs(int node, int p, List<List<Integer>> graph, int[] parent, boolean[] visited) {
        parent[node] = p;
        visited[node] = true;
        for (int neighbor : graph.get(node)) {
            if (!visited[neighbor]) {
                dfs(neighbor, node, graph, parent, visited);
            }
        }
    }

    private void dfsDepth(int node, int p, List<List<Integer>> graph, int[] depth) {
        for (int neighbor : graph.get(node)) {
            if (neighbor != p) {
                depth[neighbor] = depth[node] + 1;
                dfsDepth(neighbor, node, graph, depth);
            }
        }
    }

    private int findLCA(int u, int v, int[] parent, int[] depth) {
        while (depth[u] > depth[v]) {
            u = parent[u];
        }
        while (depth[v] > depth[u]) {
            v = parent[v];
        }
        while (u != v) {
            u = parent[u];
            v = parent[v];
        }
        return u;
    }

    private boolean isOnPath(int node, int start, int end, int[] parent) {
        int curr = node;
        while (curr != -1) {
            if (curr == start) return true;
            curr = parent[curr];
        }
        return false;
    }
}
}