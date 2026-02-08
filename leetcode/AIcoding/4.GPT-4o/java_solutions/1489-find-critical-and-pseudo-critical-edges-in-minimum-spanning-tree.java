class Solution {
    public List<List<Integer>> findCriticalAndPseudoCriticalEdges(int n, int[][] edges) {
        List<List<Integer>> result = new ArrayList<>();
        List<int[]> edgeList = new ArrayList<>();

        for (int i = 0; i < edges.length; i++) {
            edgeList.add(new int[]{edges[i][0], edges[i][1], edges[i][2], i});
        }
        Collections.sort(edgeList, (a, b) -> Integer.compare(a[2], b[2]));

        int[] parent = new int[n];
        int[] rank = new int[n];

        for (int i = 0; i < n; i++) {
            parent[i] = i;
            rank[i] = 0;
        }

        int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                if (rank[rootX] > rank[rootY]) {
                    parent[rootY] = rootX;
                } else if (rank[rootX] < rank[rootY]) {
                    parent[rootX] = rootY;
                } else {
                    parent[rootY] = rootX;
                    rank[rootX]++;
                }
            }
        }

        int kruskal(int skipEdge, int takeEdge) {
            Arrays.fill(parent, 0, n, 0);
            Arrays.fill(rank, 0, n, 0);
            int cost = 0;
            int edgesUsed = 0;
            if (takeEdge != -1) {
                cost += edgeList.get(takeEdge)[2];
                union(edgeList.get(takeEdge)[0], edgeList.get(takeEdge)[1]);
                edgesUsed++;
            }
            for (int i = 0; i < edgeList.size(); i++) {
                if (i == skipEdge) continue;
                int[] edge = edgeList.get(i);
                if (find(edge[0]) != find(edge[1])) {
                    union(edge[0], edge[1]);
                    cost += edge[2];
                    edgesUsed++;
                }
            }
            return edgesUsed == n - 1 ? cost : Integer.MAX_VALUE;
        }

        int minCost = kruskal(-1, -1);
        List<Integer> critical = new ArrayList<>();
        List<Integer> pseudoCritical = new ArrayList<>();

        for (int i = 0; i < edgeList.size(); i++) {
            if (kruskal(i, -1) > minCost) {
                critical.add(edgeList.get(i)[3]);
            } else if (kruskal(-1, i) == minCost) {
                pseudoCritical.add(edgeList.get(i)[3]);
            }
        }

        result.add(critical);
        result.add(pseudoCritical);
        return result;
    }
}