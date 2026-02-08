class Solution {
    public long[] maximumSegmentSum(int[] nums, int[] removeQueries) {
        int n = nums.length;
        long[] res = new long[n];
        int[] parent = new int[n];
        long[] sum = new long[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            sum[i] = nums[i];
        }
        long max = 0;
        for (int i = n - 1; i > 0; i--) {
            int u = removeQueries[i];
            res[i] = max;
            if (u > 0 && parent[u - 1] != u - 1) {
                union(parent, sum, u - 1, u);
            }
            if (u < n - 1 && parent[u + 1] != u + 1) {
                union(parent, sum, u, u + 1);
            }
            max = Math.max(max, sum[find(parent, u)]);
        }
        res[0] = max;
        return res;
    }

    private int find(int[] parent, int u) {
        if (parent[u] != u) {
            parent[u] = find(parent, parent[u]);
        }
        return parent[u];
    }

    private void union(int[] parent, long[] sum, int u, int v) {
        int pu = find(parent, u);
        int pv = find(parent, v);
        if (pu != pv) {
            parent[pv] = pu;
            sum[pu] += sum[pv];
        }
    }
}