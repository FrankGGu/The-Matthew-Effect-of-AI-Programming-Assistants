class Solution {
    public int maximumScore(int[] scores, int[][] edges) {
        int n = scores.length;
        List<Integer>[] graph = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph[u].add(v);
            graph[v].add(u);
        }
        for (int i = 0; i < n; i++) {
            Collections.sort(graph[i], (a, b) -> scores[b] - scores[a]);
        }
        int maxScore = -1;
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            int currentScore = scores[u] + scores[v];
            for (int i = 0; i < Math.min(3, graph[u].size()); i++) {
                int x = graph[u].get(i);
                if (x == v) continue;
                for (int j = 0; j < Math.min(3, graph[v].size()); j++) {
                    int y = graph[v].get(j);
                    if (y == u || y == x) continue;
                    maxScore = Math.max(maxScore, currentScore + scores[x] + scores[y]);
                }
            }
        }
        return maxScore;
    }
}