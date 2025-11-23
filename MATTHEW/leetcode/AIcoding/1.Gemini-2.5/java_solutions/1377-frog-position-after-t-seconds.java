import java.util.ArrayList;
import java.util.List;

class Solution {
    List<List<Integer>> adj;
    int targetNode;
    int maxTime;

    public double frogPosition(int n, int[][] edges, int t, int target) {
        adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        this.targetNode = target;
        this.maxTime = t;

        return dfs(1, 0, 0, 1.0);
    }

    private double dfs(int u, int parent, int currentTime, double currentProb) {
        // Calculate number of actual children (excluding parent)
        int numChildren = 0;
        for (int v : adj.get(u)) {
            if (v != parent) {
                numChildren++;
            }
        }

        // Condition 1: If current node is the target
        if (u == targetNode) {
            // If time matches exactly, this is a valid path.
            if (currentTime == maxTime) {
                return currentProb;
            }
            // If time is less than maxTime, but it's a leaf (or only has parent as neighbor),
            // the frog stays here. This is a valid path.
            if (currentTime < maxTime && numChildren == 0) {
                return currentProb;
            }
            // If time is less than maxTime and it has children, the frog must jump away.
            // So, it won't be at the target at `maxTime` by staying.
            // Or if time is greater than maxTime (overshot), it's not valid.
            return 0.0;
        }

        // Condition 2: If time is up, but we are not at target. This path is not valid.
        if (currentTime == maxTime) {
            return 0.0;
        }

        // Condition 3: If we are not at target, time is not up, but there are no children to jump to.
        // The frog stays here. This path cannot reach the target.
        if (numChildren == 0) {
            return 0.0;
        }

        // Recursive step: explore children
        double totalProb = 0.0;
        double probToJump = currentProb / numChildren;

        for (int v : adj.get(u)) {
            if (v != parent) {
                totalProb += dfs(v, u, currentTime + 1, probToJump);
            }
        }

        return totalProb;
    }
}