import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public int[] smallestMissingValueSubtree(int[] parents, int[] nums) {
        int n = parents.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int i = 1; i < n; i++) {
            adj.get(parents[i]).add(i);
        }

        int[] ans = new int[n];
        for (int i = 0; i < n; i++) {
            ans[i] = 1;
        }

        int node = -1;
        for (int i = 0; i < n; i++) {
            if (nums[i] == 1) {
                node = i;
                break;
            }
        }

        if (node == -1) {
            return ans;
        }

        Set<Integer> seen = new HashSet<>();
        int missing = 1;
        while (node != -1) {
            dfs(node, nums, adj, seen);
            while (seen.contains(missing)) {
                missing++;
            }
            ans[node] = missing;
            node = parents[node];
        }

        return ans;
    }

    private void dfs(int node, int[] nums, List<List<Integer>> adj, Set<Integer> seen) {
        seen.add(nums[node]);
        for (int child : adj.get(node)) {
            if (!seen.contains(nums[child])) {
                dfs(child, nums, adj, seen);
            }
        }
    }
}