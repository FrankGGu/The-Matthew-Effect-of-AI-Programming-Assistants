import java.util.ArrayList;
import java.util.List;

class Solution {
    private List<List<Integer>> adj;
    private int[] weights;
    private int N;
    private long totalWeightSum;
    private long maxScore;

    public long maximizeSumOfWeights(int n, int[][] edges, int[] weights) {
        this.N = n;
        this.weights = weights;
        this.adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        this.totalWeightSum = 0;
        for (int weight : weights) {
            totalWeightSum += weight;
        }

        this.maxScore = 0;

        dfs(0, -1);

        return maxScore;
    }

    private long[] dfs(int u, int p) {
        long currentSubtreeNodeCount = 1;
        long currentSubtreeWeightSum = weights[u];

        for (int v : adj.get(u)) {
            if (v == p) {
                continue;
            }

            long[] childResult = dfs(v, u);
            long childNodeCount = childResult[0];
            long childWeightSum = childResult[1];

            currentSubtreeNodeCount += childNodeCount;
            currentSubtreeWeightSum += childWeightSum;

            long score1 = childNodeCount * childWeightSum;
            long score2 = (N - childNodeCount) * (totalWeightSum - childWeightSum);

            maxScore = Math.max(maxScore, score1 + score2);
        }

        return new long[]{currentSubtreeNodeCount, currentSubtreeWeightSum};
    }
}