class Solution {
    public int numberOfGoodPaths(int[] vals, int[][] edges) {
        int n = vals.length;
        List<Integer>[] adj = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            adj[u].add(v);
            adj[v].add(u);
        }

        Map<Integer, List<Integer>> valueToNodes = new TreeMap<>();
        for (int i = 0; i < n; i++) {
            valueToNodes.computeIfAbsent(vals[i], k -> new ArrayList<>()).add(i);
        }

        UnionFind uf = new UnionFind(n);
        int result = 0;

        for (int val : valueToNodes.keySet()) {
            List<Integer> nodes = valueToNodes.get(val);
            for (int node : nodes) {
                for (int neighbor : adj[node]) {
                    if (vals[neighbor] <= val) {
                        uf.union(node, neighbor);
                    }
                }
            }

            Map<Integer, Integer> parentCount = new HashMap<>();
            for (int node : nodes) {
                int parent = uf.find(node);
                parentCount.put(parent, parentCount.getOrDefault(parent, 0) + 1);
            }

            for (int count : parentCount.values()) {
                result += count * (count + 1) / 2;
            }
        }

        return result;
    }

    class UnionFind {
        private int[] parent;
        private int[] rank;

        public UnionFind(int size) {
            parent = new int[size];
            rank = new int[size];
            for (int i = 0; i < size; i++) {
                parent[i] = i;
                rank[i] = 1;
            }
        }

        public int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        public void union(int x, int y) {
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
    }
}