class Solution {
    int maxLen = 0;

    public int longestPath(int[] parent, String s) {
        int n = parent.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int i = 1; i < n; i++) {
            adj.get(parent[i]).add(i);
        }

        dfs(0, adj, s);
        return maxLen;
    }

    private int dfs(int node, List<List<Integer>> adj, String s) {
        int longestChain = 0;
        int secondLongestChain = 0;

        for (int child : adj.get(node)) {
            int chainLen = dfs(child, adj, s);
            if (s.charAt(node) != s.charAt(child)) {
                if (chainLen > longestChain) {
                    secondLongestChain = longestChain;
                    longestChain = chainLen;
                } else if (chainLen > secondLongestChain) {
                    secondLongestChain = chainLen;
                }
            }
        }

        maxLen = Math.max(maxLen, longestChain + secondLongestChain + 1);
        return longestChain + 1;
    }
}