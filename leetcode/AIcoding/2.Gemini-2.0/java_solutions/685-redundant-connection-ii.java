class Solution {
    public int[] findRedundantDirectedConnection(int[][] edges) {
        int n = edges.length;
        int[] parent = new int[n + 1];
        int[] inDegree = new int[n + 1];
        int first = -1, second = -1;

        for (int[] edge : edges) {
            inDegree[edge[1]]++;
        }

        for (int i = 0; i < n; i++) {
            if (inDegree[edges[i][1]] > 1) {
                if (first == -1) {
                    first = i;
                } else {
                    second = i;
                }
            }
        }

        if (first != -1) {
            if (second == -1) {
                int u = edges[first][0];
                int v = edges[first][1];

                for(int i=0;i<=n;i++){
                    parent[i] = i;
                }

                for(int i=0;i<edges.length;i++){
                    if(i == first) continue;
                    int pu = find(parent, edges[i][0]);
                    int pv = find(parent, edges[i][1]);

                    if(pu == pv) return edges[first];

                    parent[pv] = pu;
                }

                return edges[first];

            } else {
                 int u1 = edges[first][0];
                int v1 = edges[first][1];
                int u2 = edges[second][0];
                int v2 = edges[second][1];

                for(int i=0;i<=n;i++){
                    parent[i] = i;
                }

                for(int i=0;i<edges.length;i++){
                    if(i == second) continue;
                    int pu = find(parent, edges[i][0]);
                    int pv = find(parent, edges[i][1]);

                    if(pu == pv) return edges[second];

                    parent[pv] = pu;
                }
                return edges[second];

            }
        } else {
            for(int i=0;i<=n;i++){
                parent[i] = i;
            }

            for(int[] edge : edges){
                int pu = find(parent, edge[0]);
                int pv = find(parent, edge[1]);

                if(pu == pv) return edge;

                parent[pv] = pu;
            }
        }

        return new int[0];
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }
}