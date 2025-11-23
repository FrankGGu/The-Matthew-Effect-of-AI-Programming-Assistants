import java.util.*;

class Solution {
    public boolean isPossible(int n, int[][] edges) {
        List<Integer>[] adj = new List[n + 1];
        for (int i = 1; i <= n; i++) {
            adj[i] = new ArrayList<>();
        }

        int[] degree = new int[n + 1];
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].add(v);
            adj[v].add(u);
            degree[u]++;
            degree[v]++;
        }

        List<Integer> oddNodes = new ArrayList<>();
        for (int i = 1; i <= n; i++) {
            if (degree[i] % 2 != 0) {
                oddNodes.add(i);
            }
        }

        if (oddNodes.size() == 0) {
            return true;
        }

        if (oddNodes.size() > 4) {
            return false;
        }

        if (oddNodes.size() == 2) {
            int u = oddNodes.get(0);
            int v = oddNodes.get(1);
            if (!adj[u].contains(v)) {
                return true;
            }
            for (int i = 1; i <= n; i++) {
                if (i != u && i != v) {
                    return true;
                }
            }
            return false;
        }

        if (oddNodes.size() == 4) {
            int u = oddNodes.get(0);
            int v = oddNodes.get(1);
            int x = oddNodes.get(2);
            int y = oddNodes.get(3);
            if (!adj[u].contains(v) && !adj[x].contains(y)) {
                return true;
            }
            if (!adj[u].contains(x) && !adj[v].contains(y)) {
                return true;
            }
            if (!adj[u].contains(y) && !adj[v].contains(x)) {
                return true;
            }
            return false;
        }

        return false;
    }
}