import java.util.*;

class Solution {
    public int numberOfGoodPaths(int[] vals, int[][] edges) {
        int n = vals.length;

        // Adjacency list to represent the tree
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        // Store nodes as (value, index) pairs and sort them by value
        List<int[]> sortedNodes = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            sortedNodes.add(new int[]{vals[i], i});
        }
        Collections.sort(sortedNodes, (a, b) -> a[0] - b[0]);

        DSU dsu = new DSU(n);
        long goodPaths = 0;

        // Iterate through sorted nodes, grouping nodes with the same value
        for (int i = 0; i < n; ) {
            int currVal = sortedNodes.get(i)[0];
            int j = i;
            while (j < n && sortedNodes.get(j)[0] == currVal) {
                j++;
            }
            // Nodes from index i to j-1 all have value `currVal`

            // Step 1: Process connections for all nodes with value `currVal`
            // For each node `u` with value `currVal`, union it with its neighbors `v`
            // if `vals[v] <= currVal`. This ensures that we only form paths
            // where intermediate nodes have values less than or equal to `currVal`.
            for (int k = i; k < j; k++) {
                int u = sortedNodes.get(k)[1];
                for (int v : adj.get(u)) {
                    if (vals[v] <= currVal) {
                        dsu.union(u, v);
                    }
                }
            }

            // Step 2: Count good paths within components for nodes of value `currVal`
            // After processing connections, for each connected component, count how many nodes
            // within that component have the value `currVal`.
            // If a component has `C` nodes with value `currVal`, then any pair of these `C` nodes
            // can form a good path. This includes paths from a node to itself.
            // The number of such paths is C * (C + 1) / 2.
            Map<Integer, Integer> rootToCountOfCurrValNodes = new HashMap<>();
            for (int k = i; k < j; k++) {
                int node = sortedNodes.get(k)[1];
                int root = dsu.find(node);
                rootToCountOfCurrValNodes.put(root, rootToCountOfCurrValNodes.getOrDefault(root, 0) + 1);
            }

            for (int count : rootToCountOfCurrValNodes.values()) {
                goodPaths += (long) count * (count + 1) / 2;
            }

            // Move to the next group of nodes with a different value
            i = j; 
        }

        return (int) goodPaths;
    }

    // Disjoint Set Union (DSU) class
    private static class DSU {
        int[] parent;
        int[] size; // For union by size optimization

        DSU(int n) {
            parent = new int[n];
            size = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
                size[i] = 1;
            }
        }

        int find(int i) {
            if (parent[i] == i) {
                return i;
            }
            return parent[i] = find(parent[i]);
        }

        void union(int i, int j) {
            int rootI = find(i);
            int rootJ = find(j);

            if (rootI != rootJ) {
                // Union by size: attach smaller tree under root of larger tree
                if (size[rootI] < size[rootJ]) {
                    int temp = rootI;
                    rootI = rootJ;
                    rootJ = temp;
                }
                parent[rootJ] = rootI;
                size[rootI] += size[rootJ];
            }
        }
    }
}