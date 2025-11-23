import java.util.*;

class Solution {
    private List<List<Integer>> adj;
    private int[] charVals;
    private long ans;
    private Map<Integer, Integer> freq;

    public long countPalindromePaths(int[] parent, String s) {
        int n = parent.length;
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int i = 1; i < n; i++) {
            adj.get(parent[i]).add(i);
        }

        charVals = new int[n];
        for (int i = 0; i < n; i++) {
            charVals[i] = 1 << (s.charAt(i) - 'a');
        }

        ans = 0;
        freq = new HashMap<>();
        freq.put(0, 1); // Represents the state before starting DFS from root (path mask 0)

        dfs(0, 0);

        return ans;
    }

    private void dfs(int u, int currentMaskFromParent) {
        // Calculate the mask for the path from root to node u
        int currentPathMask = currentMaskFromParent ^ charVals[u];

        // Count paths ending at u that form a palindrome
        // A path v-u forms a palindrome if mask(root->v) ^ mask(root->u) is 0 or a power of 2.
        // This means mask(root->v) must be equal to mask(root->u) (for mask 0)
        // or mask(root->v) must be equal to mask(root->u) ^ (1 << i) (for mask 1 << i)

        // Case 1: Path mask is 0 (all characters appear an even number of times)
        // We need mask(root->v) == currentPathMask
        ans += freq.getOrDefault(currentPathMask, 0);

        // Case 2: Path mask is a power of 2 (exactly one character appears an odd number of times)
        // We need mask(root->v) == currentPathMask ^ (1 << i) for some i from 0 to 25
        for (int i = 0; i < 26; i++) {
            ans += freq.getOrDefault(currentPathMask ^ (1 << i), 0);
        }

        // Add current node's path mask to frequency map
        freq.put(currentPathMask, freq.getOrDefault(currentPathMask, 0) + 1);

        // Recurse for children
        for (int v : adj.get(u)) {
            dfs(v, currentPathMask);
        }

        // Backtrack: remove current node's path mask from frequency map
        // This ensures that `freq` only contains masks of nodes in the current path from root to u's ancestors.
        freq.put(currentPathMask, freq.get(currentPathMask) - 1);
    }
}