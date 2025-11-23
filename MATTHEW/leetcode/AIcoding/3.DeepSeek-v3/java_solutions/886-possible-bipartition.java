class Solution {
    public boolean possibleBipartition(int N, int[][] dislikes) {
        List<Integer>[] graph = new ArrayList[N + 1];
        for (int i = 1; i <= N; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] dislike : dislikes) {
            graph[dislike[0]].add(dislike[1]);
            graph[dislike[1]].add(dislike[0]);
        }
        int[] colors = new int[N + 1];
        for (int i = 1; i <= N; i++) {
            if (colors[i] == 0 && !dfs(graph, colors, i, 1)) {
                return false;
            }
        }
        return true;
    }

    private boolean dfs(List<Integer>[] graph, int[] colors, int node, int color) {
        colors[node] = color;
        for (int neighbor : graph[node]) {
            if (colors[neighbor] == color) {
                return false;
            }
            if (colors[neighbor] == 0 && !dfs(graph, colors, neighbor, -color)) {
                return false;
            }
        }
        return true;
    }
}