class Solution {
    public int numberOfGoodPaths(int[] vals, int[][] edges) {
        int n = vals.length;
        UnionFind uf = new UnionFind(n);

        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.computeIfAbsent(edge[0], k -> new ArrayList<>()).add(edge[1]);
            graph.computeIfAbsent(edge[1], k -> new ArrayList<>()).add(edge[0]);
        }

        Map<Integer, List<Integer>> valueMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            valueMap.computeIfAbsent(vals[i], k -> new ArrayList<>()).add(i);
        }

        int result = 0;
        List<Integer> sortedKeys = new ArrayList<>(valueMap.keySet());
        Collections.sort(sortedKeys);

        for (int key : sortedKeys) {
            List<Integer> nodes = valueMap.get(key);
            for (int node : nodes) {
                for (int neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                    if (vals[neighbor] <= key) {
                        uf.union(node, neighbor);
                    }
                }
            }

            Map<Integer, Integer> countMap = new HashMap<>();
            for (int node : nodes) {
                int root = uf.find(node);
                countMap.put(root, countMap.getOrDefault(root, 0) + 1);
            }

            for (int count : countMap.values()) {
                result += count * (count + 1) / 2;
            }
        }

        return result;
    }
}

class UnionFind {
    int[] parent;
    int[] rank;

    UnionFind(int n) {
        parent = new int[n];
        rank = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            rank[i] = 1;
        }
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
}