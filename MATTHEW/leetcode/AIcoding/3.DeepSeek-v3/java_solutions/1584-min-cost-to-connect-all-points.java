import java.util.PriorityQueue;

class Solution {
    public int minCostConnectPoints(int[][] points) {
        int n = points.length;
        if (n == 1) return 0;

        PriorityQueue<int[]> minHeap = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        boolean[] visited = new boolean[n];
        int result = 0;
        int connected = 0;

        int[] point = points[0];
        for (int j = 1; j < n; j++) {
            int[] next = points[j];
            int dist = Math.abs(point[0] - next[0]) + Math.abs(point[1] - next[1]);
            minHeap.offer(new int[]{0, j, dist});
        }
        visited[0] = true;
        connected++;

        while (connected < n && !minHeap.isEmpty()) {
            int[] edge = minHeap.poll();
            int u = edge[0];
            int v = edge[1];
            int cost = edge[2];

            if (!visited[v]) {
                visited[v] = true;
                result += cost;
                connected++;

                for (int j = 0; j < n; j++) {
                    if (!visited[j]) {
                        int dist = Math.abs(points[v][0] - points[j][0]) + Math.abs(points[v][1] - points[j][1]);
                        minHeap.offer(new int[]{v, j, dist});
                    }
                }
            }
        }

        return result;
    }
}