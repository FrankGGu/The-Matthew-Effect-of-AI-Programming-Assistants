import java.util.*;

class Solution {
    public int[] getCoprimes(int[] nums, int[][] edges) {
        int n = nums.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] ans = new int[n];
        Arrays.fill(ans, -1);

        List<Map<Integer, Integer>> ancestors = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            ancestors.add(new HashMap<>());
        }

        dfs(0, -1, 0, nums, adj, ans, ancestors);

        return ans;
    }

    private void dfs(int node, int parent, int depth, int[] nums, List<List<Integer>> adj, int[] ans, List<Map<Integer, Integer>> ancestors) {
        int closestAncestor = -1;
        int minDepth = Integer.MAX_VALUE;

        for (int i = 1; i <= 50; i++) {
            if (gcd(nums[node], i) == 1) {
                for (int j = depth; j >= 0; j--) {
                   if (ancestors.get(j).containsKey(i)) {
                       if (j < minDepth) {
                           minDepth = j;
                           closestAncestor = ancestors.get(j).get(i);
                       }
                       break;
                   }
                }
            }
        }

        ans[node] = closestAncestor;

        int prev = -1;
        if(ancestors.get(depth).containsKey(nums[node])) {
            prev = ancestors.get(depth).get(nums[node]);
        }

        ancestors.get(depth).put(nums[node], node);

        for (int neighbor : adj.get(node)) {
            if (neighbor != parent) {
                dfs(neighbor, node, depth + 1, nums, adj, ans, ancestors);
            }
        }

        ancestors.get(depth).remove(nums[node]);
        if(prev != -1) {
            ancestors.get(depth).put(nums[node], prev);
        }
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
}