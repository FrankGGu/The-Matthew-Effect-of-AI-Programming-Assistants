import java.util.*;

class Solution {
    private int[] favorite;
    private int n;
    private int[] visited; // 0: unvisited, 1: visiting, 2: visited
    private boolean[] onCycle;
    private int totalLongCyclesLen;
    private List<int[]> twoCycles;

    public int maximumInvitations(int[] favorite) {
        this.favorite = favorite;
        this.n = favorite.length;
        this.visited = new int[n];
        this.onCycle = new boolean[n];
        this.totalLongCyclesLen = 0;
        this.twoCycles = new ArrayList<>();

        // Step 1: Find all cycles and mark cycle nodes
        // Also categorize cycles into length > 2 and length == 2
        for (int i = 0; i < n; i++) {
            if (visited[i] == 0) {
                dfs(i, new ArrayList<>());
            }
        }

        // Step 2: Calculate max_branch_len for nodes leading into cycles
        // max_branch_len[u] stores the maximum length of a path v -> ... -> u
        // where v is a leaf (in-degree 0 in the non-cycle part) and all nodes on the path
        // (except u if u is a cycle node) are non-cycle nodes.
        int[] inDegreeForTrees = new int[n];
        for (int i = 0; i < n; i++) {
            if (!onCycle[i]) { // Only consider non-cycle nodes for tree structure
                int v = favorite[i];
                if (!onCycle[v]) { // If v is also a non-cycle node
                    inDegreeForTrees[v]++;
                }
            }
        }

        int[] maxBranchLen = new int[n]; // Initialized to 0
        Queue<Integer> q = new LinkedList<>();

        for (int i = 0; i < n; i++) {
            // Add leaves of the in-trees (non-cycle nodes with no incoming non-cycle edges)
            if (!onCycle[i] && inDegreeForTrees[i] == 0) {
                q.offer(i);
            }
        }

        while (!q.isEmpty()) {
            int u = q.poll();
            int v = favorite[u]; // u points to v

            // Update maxBranchLen for v
            maxBranchLen[v] = Math.max(maxBranchLen[v], maxBranchLen[u] + 1);

            // If v is also a non-cycle node, continue topological sort
            if (!onCycle[v]) {
                inDegreeForTrees[v]--;
                if (inDegreeForTrees[v] == 0) {
                    q.offer(v);
                }
            }
        }

        // Step 3: Calculate total contribution from 2-cycles and their attached trees
        int sumTwoCycleTreesLen = 0;
        for (int[] cycle : twoCycles) {
            int a = cycle[0];
            int b = cycle[1];
            // For a 2-cycle A <-> B, we can invite A, B, and all nodes in trees leading to A or B.
            // The number of nodes in such a tree ending at A (including A) is 1 + maxBranchLen[A].
            sumTwoCycleTreesLen += (1 + maxBranchLen[a]) + (1 + maxBranchLen[b]);
        }

        // The total maximum is the sum of all long cycles, plus the sum of all 2-cycles with their attached trees.
        // This is because these two types of structures are disjoint in terms of nodes.
        return totalLongCyclesLen + sumTwoCycleTreesLen;
    }

    private void dfs(int u, List<Integer> path) {
        visited[u] = 1; // Mark as visiting
        path.add(u);

        int v = favorite[u];
        if (visited[v] == 1) { // Cycle detected
            int cycleLen = 0;
            boolean inCurrentCycle = false;
            int cycleStartNode = -1;

            // Extract cycle from path
            for (int node : path) {
                if (node == v) {
                    inCurrentCycle = true;
                    cycleStartNode = node;
                }
                if (inCurrentCycle) {
                    cycleLen++;
                    onCycle[node] = true; // Mark nodes as part of a cycle
                }
            }

            if (cycleLen > 2) {
                totalLongCyclesLen += cycleLen;
            } else if (cycleLen == 2) { // A <-> B
                twoCycles.add(new int[]{cycleStartNode, favorite[cycleStartNode]});
            }
        } else if (visited[v] == 0) { // Not visited, continue DFS
            dfs(v, path);
        }
        // If visited[v] == 2, it means v is part of an already processed cycle or tree leading to one.
        // No new cycle from u through v.

        path.remove(path.size() - 1); // Backtrack
        visited[u] = 2; // Mark as visited
    }
}