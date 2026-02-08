import java.util.*;

class Solution {
    public boolean isPossible(int n, List<List<Integer>> edges) {
        Set<Integer>[] adj = new HashSet[n + 1];
        int[] degree = new int[n + 1];

        for (int i = 1; i <= n; i++) {
            adj[i] = new HashSet<>();
        }

        for (List<Integer> edge : edges) {
            int u = edge.get(0);
            int v = edge.get(1);
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

        int count = oddNodes.size();

        if (count == 0) {
            return true;
        } else if (count == 2) {
            int u = oddNodes.get(0);
            int v = oddNodes.get(1);

            // Option 1: Add one edge (u, v)
            if (!adj[u].contains(v)) {
                return true;
            }

            // Option 2: Add two edges (u, x) and (v, x) for some existing node x
            // x must not be u or v, and (u,x) and (v,x) must not be existing edges
            for (int x = 1; x <= n; x++) {
                if (x == u || x == v) {
                    continue;
                }
                if (!adj[u].contains(x) && !adj[v].contains(x)) {
                    return true;
                }
            }
            return false;

        } else if (count == 4) {
            int u = oddNodes.get(0);
            int v = oddNodes.get(1);
            int x = oddNodes.get(2);
            int y = oddNodes.get(3);

            // Option 1: Add (u, v) and (x, y)
            if (!adj[u].contains(v) && !adj[x].contains(y)) {
                return true;
            }

            // Option 2: Add (u, x) and (v, y)
            if (!adj[u].contains(x) && !adj[v].contains(y)) {
                return true;
            }

            // Option 3: Add (u, y) and (v, x)
            if (!adj[u].contains(y) && !adj[v].contains(x)) {
                return true;
            }

            return false;
        } else { // count > 4 (or odd count, which is impossible)
            return false;
        }
    }
}