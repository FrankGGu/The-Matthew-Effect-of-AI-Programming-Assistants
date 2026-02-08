class Solution {
    public int[] colorTheTree(int n, int[][] edges, int[] colors) {
        List<Integer>[] adj = new List[n + 1];
        for (int i = 1; i <= n; i++) {
            adj[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            adj[edge[0]].add(edge[1]);
            adj[edge[1]].add(edge[0]);
        }

        int[] parent = new int[n + 1];
        Arrays.fill(parent, -1);
        int[] subtreeSize = new int[n + 1];

        dfs(1, -1, adj, parent, subtreeSize);

        int[] result = new int[edges.length];
        int index = 0;

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            if (parent[u] == v) {
                int costU = 0;
                int costV = 0;
                int subtreeUSize = subtreeSize[u];
                int subtreeVSize = n - subtreeSize[u];

                int uColor = colors[u-1];
                int vColor = colors[v-1];

                if(uColor != vColor){
                    costU = subtreeUSize;
                }

                result[index++] = costU;
            } else {
                int costU = 0;
                int costV = 0;
                int subtreeUSize = subtreeSize[v];
                int subtreeVSize = n - subtreeSize[v];

                int uColor = colors[u-1];
                int vColor = colors[v-1];

                if(vColor != uColor){
                    costU = subtreeUSize;
                }

                result[index++] = costU;
            }
        }

        return result;
    }

    private void dfs(int node, int par, List<Integer>[] adj, int[] parent, int[] subtreeSize) {
        parent[node] = par;
        subtreeSize[node] = 1;

        for (int neighbor : adj[node]) {
            if (neighbor != par) {
                dfs(neighbor, node, adj, parent, subtreeSize);
                subtreeSize[node] += subtreeSize[neighbor];
            }
        }
    }
}