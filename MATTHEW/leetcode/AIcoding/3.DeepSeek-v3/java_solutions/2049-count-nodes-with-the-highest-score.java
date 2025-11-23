class Solution {
    public int countHighestScoreNodes(int[] parents) {
        int n = parents.length;
        List<Integer>[] children = new List[n];
        for (int i = 0; i < n; i++) {
            children[i] = new ArrayList<>();
        }
        for (int i = 1; i < n; i++) {
            children[parents[i]].add(i);
        }
        int[] size = new int[n];
        long[] score = new long[n];
        dfs(0, children, size, score);
        long maxScore = 0;
        int count = 0;
        for (long s : score) {
            if (s > maxScore) {
                maxScore = s;
                count = 1;
            } else if (s == maxScore) {
                count++;
            }
        }
        return count;
    }

    private int dfs(int node, List<Integer>[] children, int[] size, long[] score) {
        int n = size.length;
        size[node] = 1;
        long product = 1;
        for (int child : children[node]) {
            int childSize = dfs(child, children, size, score);
            size[node] += childSize;
            product *= childSize;
        }
        if (n - size[node] > 0) {
            product *= (n - size[node]);
        }
        score[node] = product;
        return size[node];
    }
}