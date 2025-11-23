import java.util.*;

class Solution {
    public int collectTheCoins(int[] coins, int[][] edges) {
        int n = coins.length;
        if (n <= 1) {
            return 0;
        }

        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        int[] currentDegree = new int[n]; // Tracks degrees in the active graph
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
            currentDegree[u]++;
            currentDegree[v]++;
        }

        // `removed` array tracks nodes that are definitively out of the final graph.
        // It's cumulative across all pruning passes.
        boolean[] removed = new boolean[n];
        int remainingNodes = n;

        // Pass 1: Prune leaves that do not have coins. Repeat until no such leaves exist.
        // This ensures that all remaining leaves in the graph have coins.
        Queue<Integer> q = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            // A node is a candidate for removal if it's a leaf and has no coin.
            if (currentDegree[i] == 1 && coins[i] == 0) {
                q.offer(i);
            }
        }

        while (!q.isEmpty()) {
            int u = q.poll();
            if (removed[u]) { // If this node has already been removed by another path, skip
                continue;
            }

            removed[u] = true;
            remainingNodes--;

            for (int v : adj.get(u)) {
                if (!removed[v]) { // Only update degree if neighbor 'v' is not yet removed
                    currentDegree[v]--;
                    // If 'v' becomes a leaf and has no coin, add it to the queue for removal
                    if (currentDegree[v] == 1 && coins[v] == 0) {
                        q.offer(v);
                    }
                }
            }
        }

        // After Pass 1, all remaining leaves *must* have coins.
        // Now, apply the "2 levels up" rule. The problem states:
        // "You can collect a coin at node u if you have visited u twice (once going down, once coming up)
        // and have also visited its parent p twice (once going down, once coming up)."
        // This implies that for any coin at node u, its parent p and grandparent gp must also be "activated"
        // by traversing their edges. Thus, we need to keep nodes that are at least 2 edges away from a coin.
        // This is achieved by performing the "remove leaves" operation two more times.

        // Pass 2: Remove the current leaves. These are nodes 'u' in the u-p-gp path.
        // We need to keep 'p' and 'gp'. So, these 'u' nodes are removed.
        q = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (!removed[i] && currentDegree[i] == 1) { // These are the leaves in the graph after Pass 1
                q.offer(i);
            }
        }

        while (!q.isEmpty()) {
            int u = q.poll();
            if (removed[u]) {
                continue;
            }

            removed[u] = true;
            remainingNodes--;

            for (int v : adj.get(u)) {
                if (!removed[v]) { // Only update degree if neighbor 'v' is not yet removed
                    currentDegree[v]--;
                    // In this pass, we just decrement degrees. We don't add to queue for further removal
                    // based on new leaf status, because we are removing a whole layer simultaneously.
                }
            }
        }

        // Pass 3: Remove the new leaves. These are nodes 'p' in the u-p-gp path.
        // We need to keep 'gp'. So, these 'p' nodes are removed.
        q = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (!removed[i] && currentDegree[i] == 1) { // These are the new leaves after Pass 2
                q.offer(i);
            }
        }

        while (!q.isEmpty()) {
            int u = q.poll();
            if (removed[u]) {
                continue;
            }

            removed[u] = true;
            remainingNodes--;

            for (int v : adj.get(u)) {
                if (!removed[v]) { // Only update degree if neighbor 'v' is not yet removed
                    currentDegree[v]--;
                }
            }
        }

        // The remaining nodes form the "core" graph whose edges must be traversed.
        // If there are `k` remaining nodes, and they form a connected tree, there are `k-1` edges.
        // Each edge traversal costs 2 (down and up).
        if (remainingNodes <= 1) {
            return 0;
        } else {
            return 2 * (remainingNodes - 1);
        }
    }
}