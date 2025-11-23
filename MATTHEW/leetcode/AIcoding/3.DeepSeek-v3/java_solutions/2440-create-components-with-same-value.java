class Solution {
    private List<Integer>[] tree;
    private int[] nums;
    private int target;

    public int componentValue(int[] nums, int[][] edges) {
        int n = nums.length;
        this.nums = nums;
        tree = new List[n];
        for (int i = 0; i < n; i++) {
            tree[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            tree[u].add(v);
            tree[v].add(u);
        }

        int total = 0;
        for (int num : nums) {
            total += num;
        }

        int maxK = 0;
        for (int k = 1; k <= total; k++) {
            if (total % k != 0) continue;
            target = k;
            if (dfs(0, -1) == 0) {
                maxK = Math.max(maxK, total / k - 1);
            }
        }
        return maxK;
    }

    private int dfs(int u, int parent) {
        int sum = nums[u];
        for (int v : tree[u]) {
            if (v == parent) continue;
            sum += dfs(v, u);
        }
        if (sum > target) {
            return Integer.MAX_VALUE;
        }
        return sum == target ? 0 : sum;
    }
}