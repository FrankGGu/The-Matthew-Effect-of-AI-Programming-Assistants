class Solution {
    public long[] maximumSegmentSum(int[] nums, int[] removeQueries) {
        int n = nums.length;
        long[] result = new long[n];
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        int[] parent = new int[n];
        long[] sum = new long[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            sum[i] = 0;
        }

        long max = 0;
        boolean[] removed = new boolean[n];

        for (int i = 0; i < n; i++) {
            int index = removeQueries[i];
            removed[index] = true;
            sum[index] = nums[index];
            max = Math.max(max, sum[index]);

            if (index > 0 && removed[index - 1]) {
                max = Math.max(max, union(index, index - 1, parent, sum));
            }
            if (index < n - 1 && removed[index + 1]) {
                max = Math.max(max, union(index, index + 1, parent, sum));
            }

            result[i] = max;
        }

        return result;
    }

    private int find(int x, int[] parent) {
        if (parent[x] != x) {
            parent[x] = find(parent[x], parent);
        }
        return parent[x];
    }

    private long union(int x, int y, int[] parent, long[] sum) {
        int rootX = find(x, parent);
        int rootY = find(y, parent);

        if (rootX != rootY) {
            parent[rootX] = rootY;
            sum[rootY] += sum[rootX];
            return sum[rootY];
        }
        return sum[rootX];
    }
}