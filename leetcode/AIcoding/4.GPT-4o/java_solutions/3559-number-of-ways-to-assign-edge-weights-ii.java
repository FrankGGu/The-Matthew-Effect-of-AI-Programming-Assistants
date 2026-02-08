class Solution {
    public int[] assignEdgeWeights(int n, int[][] edges) {
        int[] result = new int[edges.length];
        int[] sums = new int[n + 1];
        int total = 0;

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            sums[u]++;
            sums[v]++;
            total++;
        }

        for (int i = 0; i < edges.length; i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            result[i] = total - sums[u] - sums[v] + 2;
        }

        return result;
    }
}