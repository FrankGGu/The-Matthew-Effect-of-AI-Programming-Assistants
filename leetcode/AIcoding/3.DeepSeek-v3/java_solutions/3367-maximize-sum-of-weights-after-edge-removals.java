class Solution {
    public int maxSumAfterEdgeRemoval(int[] parent, int[] weight) {
        int n = parent.length;
        List<List<Integer>> tree = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            tree.add(new ArrayList<>());
        }
        for (int i = 1; i < n; i++) {
            tree.get(parent[i]).add(i);
        }
        int[] dp = new int[n];
        int res = 0;
        for (int i = n - 1; i >= 0; i--) {
            int max1 = 0, max2 = 0;
            for (int child : tree.get(i)) {
                if (dp[child] > max1) {
                    max2 = max1;
                    max1 = dp[child];
                } else if (dp[child] > max2) {
                    max2 = dp[child];
                }
            }
            dp[i] = max1 + weight[i];
            res = Math.max(res, max1 + max2 + weight[i]);
        }
        return res;
    }
}