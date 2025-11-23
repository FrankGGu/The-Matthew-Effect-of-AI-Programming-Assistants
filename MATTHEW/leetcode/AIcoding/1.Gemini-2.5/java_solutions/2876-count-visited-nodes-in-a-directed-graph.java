import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    private int[] ans;
    private int[] status; // 0: unvisited, 1: visiting (on current path), 2: visited and processed
    private int[] edges;

    // path stores nodes in the current DFS recursion stack
    private List<Integer> path;
    // pathIdxMap stores the index of a node in the current 'path' list
    private Map<Integer, Integer> pathIdxMap;

    public int[] countVisitedNodes(int[] edges) {
        int n = edges.length;
        this.edges = edges;
        ans = new int[n];
        status = new int[n]; // Initialized to 0 by default
        path = new ArrayList<>();
        pathIdxMap = new HashMap<>();

        for (int i = 0; i < n; i++) {
            if (status[i] == 0) { // If node not yet visited, start a DFS
                dfs(i);
            }
        }

        return ans;
    }

    private void dfs(int u) {
        status[u] = 1; // Mark as visiting (on current path)
        pathIdxMap.put(u, path.size());
        path.add(u);

        int v = edges[u]; // Next node in the path

        if (status[v] == 0) { // If v is unvisited, recurse
            dfs(v);
            // After dfs(v) returns, u might have been processed if it was part of a cycle
            // or a path segment that was resolved by dfs(v).
            // Only if u is still 'visiting' (status[u] == 1), calculate its ans.
            if (status[u] == 1) {
                ans[u] = 1 + ans[v];
            }
        } else if (status[v] == 1) { // Cycle detected: v is currently in the recursion stack
            int cycleStartIdx = pathIdxMap.get(v);
            int cycleLen = path.size() - cycleStartIdx;

            // All nodes in the cycle get the cycle length
            for (int i = cycleStartIdx; i < path.size(); i++) {
                int nodeInCycle = path.get(i);
                ans[nodeInCycle] = cycleLen;
                status[nodeInCycle] = 2; // Mark as processed
            }

            // Nodes leading to the cycle (before cycleStartIdx in the current path)
            // get cycle length + distance to the cycle
            for (int i = 0; i < cycleStartIdx; i++) {
                int nodeLeadingToCycle = path.get(i);
                ans[nodeLeadingToCycle] = cycleLen + (cycleStartIdx - i);
                status[nodeLeadingToCycle] = 2; // Mark as processed
            }
            // No explicit return here. Execution will continue to step 8,
            // where `u` and its ancestors will be correctly removed from `path`
            // and `pathIdxMap` as their `status` is now 2.
        } else { // status[v] == 2: v has already been visited and processed
            // u leads to an already processed component
            ans[u] = 1 + ans[v];
        }

        // After processing u (either its ans was calculated or it was part of a cycle),
        // mark u as fully processed and remove it from the current path.
        // This handles both cases:
        // 1. u's status was 1 (ans calculated in step 5 or 7).
        // 2. u's status became 2 (it was part of a cycle in step 6).
        status[u] = 2; 
        path.remove(path.size() - 1);
        pathIdxMap.remove(u);
    }
}