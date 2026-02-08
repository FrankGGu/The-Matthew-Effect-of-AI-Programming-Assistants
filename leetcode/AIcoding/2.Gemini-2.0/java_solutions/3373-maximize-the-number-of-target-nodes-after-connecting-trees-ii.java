import java.util.*;

class Solution {
    public int maximizeTheNumberOfTargetNodes(List<List<Integer>> edges) {
        int n = 0;
        Set<Integer> nodes = new HashSet<>();
        for (List<Integer> edge : edges) {
            nodes.add(edge.get(0));
            nodes.add(edge.get(1));
            n = Math.max(n, Math.max(edge.get(0), edge.get(1)));
        }
        n++;
        List<Integer>[] adj = new List[n];
        int[] inDegree = new int[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }
        for (List<Integer> edge : edges) {
            int u = edge.get(0);
            int v = edge.get(1);
            adj[u].add(v);
            inDegree[v]++;
        }

        List<Integer> roots = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (nodes.contains(i) && inDegree[i] == 0) {
                roots.add(i);
            }
        }

        int ans = 0;
        for (int root : roots) {
            int[] dp = dfs(root, adj);
            ans += Math.max(dp[0], dp[1]);
        }
        return ans;
    }

    private int[] dfs(int u, List<Integer>[] adj) {
        int include = 1;
        int exclude = 0;
        for (int v : adj[u]) {
            int[] dp = dfs(v, adj);
            exclude += Math.max(dp[0], dp[1]);
            include += dp[0];
        }
        return new int[]{exclude, include};
    }
}