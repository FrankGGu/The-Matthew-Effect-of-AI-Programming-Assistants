import java.util.ArrayList;
import java.util.List;

class Solution {

    // 0: unvisited
    // 1: visiting (currently in recursion stack)
    // 2: safe
    // 3: unsafe
    private int[] state;
    private int[][] graph;

    public List<Integer> eventualSafeNodes(int[][] graph) {
        int n = graph.length;
        this.graph = graph;
        this.state = new int[n]; // Initialize with 0 (unvisited)

        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (dfs(i)) {
                result.add(i);
            }
        }
        return result;
    }

    private boolean dfs(int u) {
        if (state[u] != 0) { // If already visited or being visited
            return state[u] == 2; // Return true if safe, false if unsafe or visiting (cycle detected)
        }

        state[u] = 1; // Mark as visiting

        for (int v : graph[u]) {
            if (!dfs(v)) { // If any neighbor leads to an unsafe state or a cycle
                state[u] = 3; // Mark u as unsafe
                return false;
            }
        }

        state[u] = 2; // If all neighbors lead to safe states, mark u as safe
        return true;
    }
}