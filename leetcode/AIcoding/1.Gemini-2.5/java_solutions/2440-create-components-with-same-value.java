import java.util.*;

class Solution {
    List<List<Integer>> adj;
    int[] nums;
    int countCuts;

    public int componentCount(int n, int[][] edges, int[] nums) {
        this.nums = nums;
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        long totalSum = 0;
        for (int x : nums) {
            totalSum += x;
        }

        for (int k = n; k >= 1; k--) {
            if (totalSum % k == 0) {
                long targetSum = totalSum / k;

                countCuts = 0;
                long remainingSum = dfs(0, -1, targetSum);

                if (remainingSum == 0 && countCuts == k) {
                    return k;
                }
            }
        }
        return 1;
    }

    private long dfs(int u, int parent, long targetSum) {
        long currentSubtreeSum = nums[u];

        for (int v : adj.get(u)) {
            if (v == parent) {
                continue;
            }
            long childSubtreeSum = dfs(v, u, targetSum);
            if (childSubtreeSum == -1) {
                return -1;
            }
            currentSubtreeSum += childSubtreeSum;
        }

        if (currentSubtreeSum > targetSum) {
            return -1;
        }

        if (currentSubtreeSum == targetSum) {
            countCuts++;
            return 0;
        }

        return currentSubtreeSum;
    }
}