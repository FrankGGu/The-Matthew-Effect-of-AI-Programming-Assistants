class Solution {
    public int maxSum(int[][] edges, int[][] values) {
        int n = values.length;
        int[] degree = new int[n];
        for (int[] edge : edges) {
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        int res = 0;
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int sum = values[u] + values[v];
            for (int neighbor : new int[]{u, v}) {
                if (degree[neighbor] > 1) {
                    sum += values[neighbor];
                }
            }
            res = Math.max(res, sum);
        }
        return res;
    }
}