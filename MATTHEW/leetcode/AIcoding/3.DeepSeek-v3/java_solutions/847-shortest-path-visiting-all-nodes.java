class Solution {
    public int shortestPathLength(int[][] graph) {
        int n = graph.length;
        if (n == 1) return 0;

        int finalState = (1 << n) - 1;
        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[n][1 << n];

        for (int i = 0; i < n; i++) {
            queue.offer(new int[]{i, 1 << i});
            visited[i][1 << i] = true;
        }

        int steps = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            steps++;
            for (int i = 0; i < size; i++) {
                int[] current = queue.poll();
                int node = current[0];
                int state = current[1];

                for (int neighbor : graph[node]) {
                    int newState = state | (1 << neighbor);
                    if (newState == finalState) {
                        return steps;
                    }
                    if (!visited[neighbor][newState]) {
                        visited[neighbor][newState] = true;
                        queue.offer(new int[]{neighbor, newState});
                    }
                }
            }
        }
        return -1;
    }
}