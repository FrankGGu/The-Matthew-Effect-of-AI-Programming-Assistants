class Solution {
    public int[] shortestAlternatingPaths(int n, int[][] redEdges, int[][] blueEdges) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : redEdges) {
            graph.get(edge[0]).add(new int[]{edge[1], 0});
        }
        for (int[] edge : blueEdges) {
            graph.get(edge[0]).add(new int[]{edge[1], 1});
        }

        int[][] dist = new int[n][2];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dist[i], -1);
        }
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0, 0}); // node, distance, color
        queue.offer(new int[]{0, 0, 1});
        dist[0][0] = 0;
        dist[0][1] = 0;

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int node = curr[0], d = curr[1], color = curr[2];

            for (int[] neighbor : graph.get(node)) {
                int nextNode = neighbor[0], nextColor = neighbor[1];
                if (nextColor != color && dist[nextNode][nextColor] == -1) {
                    dist[nextNode][nextColor] = d + 1;
                    queue.offer(new int[]{nextNode, d + 1, nextColor});
                }
            }
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            if (dist[i][0] == -1 && dist[i][1] == -1) {
                result[i] = -1;
            } else if (dist[i][0] == -1) {
                result[i] = dist[i][1];
            } else if (dist[i][1] == -1) {
                result[i] = dist[i][0];
            } else {
                result[i] = Math.min(dist[i][0], dist[i][1]);
            }
        }

        return result;
    }
}