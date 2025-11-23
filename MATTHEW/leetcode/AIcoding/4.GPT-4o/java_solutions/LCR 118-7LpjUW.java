class Solution {
    public int[] findRedundantDirectedConnection(int[][] edges) {
        int n = edges.length;
        int[] parent = new int[n + 1];
        Arrays.fill(parent, -1);
        int[] edge1 = null, edge2 = null;

        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            if (parent[v] != -1) {
                edge1 = edge;
                edge2 = new int[]{parent[v], v};
                edge[1] = -1;
            } else {
                parent[v] = u;
            }
        }

        if (edge1 == null) {
            return new int[]{-1, -1};
        }

        boolean[] visited = new boolean[n + 1];
        if (!hasCycle(edges, visited, edge1)) {
            return edge1;
        }
        return edge2;
    }

    private boolean hasCycle(int[][] edges, boolean[] visited, int[] skip) {
        Arrays.fill(visited, false);
        for (int[] edge : edges) {
            if (edge == skip) continue;
            int u = edge[0], v = edge[1];
            if (!visited[u]) {
                visited[u] = true;
                if (dfs(edges, visited, v)) return true;
            }
        }
        return false;
    }

    private boolean dfs(int[][] edges, boolean[] visited, int node) {
        if (visited[node]) return true;
        visited[node] = true;
        for (int[] edge : edges) {
            if (edge[0] == node) {
                if (dfs(edges, visited, edge[1])) return true;
            }
        }
        visited[node] = false;
        return false;
    }
}