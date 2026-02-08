class Solution {
    public int countCompleteComponents(int n, int[][] edges) {
        UnionFind uf = new UnionFind(n);
        for (int[] edge : edges) {
            uf.union(edge[0], edge[1]);
        }

        Map<Integer, List<Integer>> components = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int root = uf.find(i);
            components.computeIfAbsent(root, k -> new ArrayList<>()).add(i);
        }

        int[] edgeCount = new int[n];
        for (int[] edge : edges) {
            int u = edge[0];
            edgeCount[u]++;
        }

        int completeComponents = 0;
        for (List<Integer> component : components.values()) {
            int size = component.size();
            boolean isComplete = true;
            for (int node : component) {
                if (edgeCount[node] != size - 1) {
                    isComplete = false;
                    break;
                }
            }
            if (isComplete) {
                completeComponents++;
            }
        }

        return completeComponents;
    }

    class UnionFind {
        private int[] parent;

        public UnionFind(int size) {
            parent = new int[size];
            for (int i = 0; i < size; i++) {
                parent[i] = i;
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
                parent[rootX] = rootY;
            }
        }
    }
}