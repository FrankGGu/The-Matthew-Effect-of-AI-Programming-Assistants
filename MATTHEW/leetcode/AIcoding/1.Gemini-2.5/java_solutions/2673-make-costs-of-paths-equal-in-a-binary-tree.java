class Solution {
    private long totalModificationCost;

    public long minCost(int[] costs) {
        totalModificationCost = 0;
        dfs(0, costs.length, costs);
        return totalModificationCost;
    }

    private long dfs(int i, int n, int[] costs) {
        if (i >= n) {
            return 0L; // Represents the path sum from a non-existent child to a leaf (0 length path)
        }

        long leftMaxPathSum = dfs(2 * i + 1, n, costs);
        long rightMaxPathSum = dfs(2 * i + 2, n, costs);

        // The cost to make the paths from left and right children equal.
        // This is added to the global modification cost.
        // We effectively increase the smaller path sum to match the larger one.
        totalModificationCost += Math.abs(leftMaxPathSum - rightMaxPathSum);

        // The value returned is the current node's original cost plus the maximum
        // of its children's path sums (after potential modification to make them equal).
        // This represents the new "effective" path sum from this node to a leaf.
        return costs[i] + Math.max(leftMaxPathSum, rightMaxPathSum);
    }
}