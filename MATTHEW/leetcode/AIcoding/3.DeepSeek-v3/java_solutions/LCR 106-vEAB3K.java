class Solution {
    public boolean isBipartite(int[][] graph) {
        int n = graph.length;
        int[] colors = new int[n];
        Arrays.fill(colors, -1);

        for (int i = 0; i < n; i++) {
            if (colors[i] == -1) {
                if (!bfs(graph, colors, i)) {
                    return false;
                }
            }
        }
        return true;
    }

    private boolean bfs(int[][] graph, int[] colors, int start) {
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(start);
        colors[start] = 0;

        while (!queue.isEmpty()) {
            int current = queue.poll();
            for (int neighbor : graph[current]) {
                if (colors[neighbor] == -1) {
                    colors[neighbor] = colors[current] ^ 1;
                    queue.offer(neighbor);
                } else if (colors[neighbor] == colors[current]) {
                    return false;
                }
            }
        }
        return true;
    }
}