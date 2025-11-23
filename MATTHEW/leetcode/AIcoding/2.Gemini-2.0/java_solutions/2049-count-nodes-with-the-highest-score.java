class Solution {
    int maxScoreNodes = 0;
    long maxScore = 0;
    int n;
    List<Integer>[] children;

    public int countHighestScoreNodes(int[] parents) {
        n = parents.length;
        children = new List[n];
        for (int i = 0; i < n; i++) {
            children[i] = new ArrayList<>();
        }
        for (int i = 0; i < n; i++) {
            if (parents[i] != -1) {
                children[parents[i]].add(i);
            }
        }
        dfs(0);
        return maxScoreNodes;
    }

    private int dfs(int node) {
        long score = 1;
        int size = 1;
        for (int child : children[node]) {
            int childSize = dfs(child);
            score *= childSize;
            size += childSize;
        }
        if (node != 0) {
            score *= (n - size);
        }
        if (score > maxScore) {
            maxScore = score;
            maxScoreNodes = 1;
        } else if (score == maxScore) {
            maxScoreNodes++;
        }
        return size;
    }
}