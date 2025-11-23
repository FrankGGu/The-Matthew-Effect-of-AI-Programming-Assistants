import java.util.*;

class Solution {
    public int[] smallestMissingValueSubtree(int[] parents, int[] vals) {
        int n = parents.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int i = 1; i < n; i++) {
            adj.get(parents[i]).add(i);
        }

        int[] ans = new int[n];
        // Initialize all answers to 1.
        // If a subtree does not contain the genetic value 1, its smallest missing value is 1.
        Arrays.fill(ans, 1);

        // Find the node that has genetic value 1.
        // If no node has value 1 in the entire tree, then all answers remain 1.
        int nodeOneIdx = -1;
        for (int i = 0; i < n; i++) {
            if (vals[i] == 1) {
                nodeOneIdx = i;
                break;
            }
        }

        // If genetic value 1 is not found in the tree, no subtree can have a smallest missing value greater than 1.
        // So all answers are 1, which is already set.
        if (nodeOneIdx == -1) {
            return ans;
        }

        // Perform DFS starting from the root (node 0).
        // The `dfs` function will compute `ans[u]` for all `u`.
        // The small-to-large merging strategy for sets ensures O(N log N) for set operations.
        // The total number of increments for `smallestMissing` across all nodes is O(N).
        // This leads to an overall time complexity of O(N log N).
        dfs(0, -1, adj, vals, ans);

        return ans;
    }

    // This DFS function computes the set of genetic values in the subtree rooted at 'u'
    // and updates ans[u] with the smallest missing genetic value for that subtree.
    // It uses small-to-large merging for sets to optimize performance.
    private Set<Integer> dfs(int u, int p, List<List<Integer>> adj, int[] vals, int[] ans) {
        // `currentSubtreeValues` will store all unique genetic values found in the subtree rooted at `u`.
        Set<Integer> currentSubtreeValues = new HashSet<>();

        // Add the current node's genetic value to the set.
        // We only care about values up to N+1. The smallest missing value cannot exceed N+1.
        // Any value greater than N+1 behaves the same as a value not in the range [1, N+1]
        // for the purpose of finding the smallest missing positive integer.
        if (vals[u] <= ans.length + 1) { // ans.length is N
            currentSubtreeValues.add(vals[u]);
        }

        // Recursively call DFS for all children of `u` and merge their sets of values.
        for (int v : adj.get(u)) {
            if (v != p) { // Avoid going back to the parent
                Set<Integer> childValues = dfs(v, u, adj, vals, ans); // Get values from child's subtree

                // Perform small-to-large merging: always merge the smaller set into the larger set.
                // This optimizes the total time for `addAll` operations to O(N log N).
                if (childValues.size() > currentSubtreeValues.size()) {
                    Set<Integer> temp = currentSubtreeValues;
                    currentSubtreeValues = childValues;
                    childValues = temp;
                }
                currentSubtreeValues.addAll(childValues);
            }
        }

        // After merging all children's sets, `currentSubtreeValues` now contains all unique
        // genetic values in the subtree rooted at `u`.
        // Now, find the smallest missing positive integer for this subtree.
        int smallestMissing = 1;
        while (currentSubtreeValues.contains(smallestMissing)) {
            smallestMissing++;
        }
        ans[u] = smallestMissing; // Store the result for node `u`

        // Return the set of values for `u`'s subtree to its parent for merging.
        return currentSubtreeValues;
    }
}