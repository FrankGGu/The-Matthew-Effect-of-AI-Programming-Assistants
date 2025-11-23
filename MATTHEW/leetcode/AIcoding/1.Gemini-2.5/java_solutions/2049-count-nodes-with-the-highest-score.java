import java.util.ArrayList;
import java.util.List;

class Solution {
    private List<Integer>[] adj;
    private int[] subtreeSize;
    private int n;

    public int countHighestScoreNodes(int[] parents) {
        n = parents.length;
        adj = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }

        for (int i = 1; i < n; i++) {
            adj[parents[i]].add(i);
        }

        subtreeSize = new int[n];
        dfsCalculateSizes(0);

        long maxScore = 0;
        int countMaxScore = 0;

        for (int i = 0; i < n; i++) {
            long currentScore = 1;

            for (int child : adj[i]) {
                currentScore *= subtreeSize[child];
            }

            long remainingSize = n - subtreeSize[i];
            if (remainingSize > 0) {
                currentScore *= remainingSize;
            }

            if (currentScore > maxScore) {
                maxScore = currentScore;
                countMaxScore = 1;
            } else if (currentScore == maxScore) {
                countMaxScore++;
            }
        }

        return countMaxScore;
    }

    private int dfsCalculateSizes(int u) {
        int size = 1;
        for (int v : adj[u]) {
            size += dfsCalculateSizes(v);
        }
        subtreeSize[u] = size;
        return size;
    }
}