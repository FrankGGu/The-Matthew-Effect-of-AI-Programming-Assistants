import java.util.Arrays;
import java.util.Comparator;

class Solution {

    private int[] parent;
    private int[] size;
    private long currentTotalPairs;

    private int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    private void union(int i, int j) {
        int rootI = find(i);
        int rootJ = find(j);

        if (rootI != rootJ) {
            // Union by size
            if (size[rootI] < size[rootJ]) {
                int temp = rootI;
                rootI = rootJ;
                rootJ = temp;
            }

            // When two components of sizes size[rootI] and size[rootJ] are merged,
            // size[rootI] * size[rootJ] new pairs are formed between nodes from different components.
            currentTotalPairs += (long) size[rootI] * size[rootJ];

            parent[rootJ] = rootI;
            size[rootI] += size[rootJ];
        }
    }

    public long[] countPairsOfNodes(int n, int[][] edges, int[] queries) {
        // Sort edges by weight in ascending order
        Arrays.sort(edges, (a, b) -> a[2] - b[2]);

        // Prepare queries with their original indices and sort by target weight
        int[][] indexedQueries = new int[queries.length][2];
        for (int i = 0; i < queries.length; i++) {
            indexedQueries[i][0] = queries[i]; // target weight
            indexedQueries[i][1] = i;          // original index
        }
        Arrays.sort(indexedQueries, (a, b) -> a[0] - b[0]);

        long[] result = new long[queries.length];

        // Initialize DSU structure
        parent = new int[n];
        size = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            size[i] = 1;
        }
        currentTotalPairs = 0;

        int edgeIndex = 0;
        for (int i = 0; i < indexedQueries.length; i++) {
            int target = indexedQueries[i][0];
            int originalQueryIndex = indexedQueries[i][1];

            // Add edges whose weights are less than or equal to the current query's target
            while (edgeIndex < edges.length && edges[edgeIndex][2] <= target) {
                int u = edges[edgeIndex][0];
                int v = edges[edgeIndex][1];
                union(u, v);
                edgeIndex++;
            }
            result[originalQueryIndex] = currentTotalPairs;
        }

        return result;
    }
}