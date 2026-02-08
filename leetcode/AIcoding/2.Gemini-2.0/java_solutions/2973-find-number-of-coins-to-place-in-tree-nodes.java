import java.util.*;

class Solution {
    public int[] placedCoins(int[][] edges, int[] cost) {
        int n = cost.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] result = new int[n];
        Arrays.fill(result, 0);

        for (int i = 0; i < n; i++) {
            List<Integer> nums = new ArrayList<>();
            dfs(i, -1, adj, cost, nums);
            Collections.sort(nums);

            if (nums.size() < 3) {
                result[i] = 0;
            } else {
                int prod1 = nums.get(0) * nums.get(1) * nums.get(nums.size() - 1);
                int prod2 = nums.get(nums.size() - 1) * nums.get(nums.size() - 2) * nums.get(nums.size() - 3);
                result[i] = Math.max(prod1, prod2);
            }
        }

        return result;
    }

    private void dfs(int node, int parent, List<List<Integer>> adj, int[] cost, List<Integer> nums) {
        nums.add(cost[node]);
        for (int neighbor : adj.get(node)) {
            if (neighbor != parent) {
                dfs(neighbor, node, adj, cost, nums);
            }
        }
    }
}