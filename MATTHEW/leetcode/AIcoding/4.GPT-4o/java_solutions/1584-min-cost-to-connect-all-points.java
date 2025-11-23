import java.util.PriorityQueue;

class Solution {
    public int minCostConnectPoints(int[][] points) {
        int n = points.length;
        boolean[] visited = new boolean[n];
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        pq.offer(new int[]{0, 0});
        int cost = 0, edges = 0;

        while (!pq.isEmpty() && edges < n) {
            int[] curr = pq.poll();
            int costToConnect = curr[0], pointIndex = curr[1];

            if (visited[pointIndex]) continue;
            visited[pointIndex] = true;
            cost += costToConnect;
            edges++;

            for (int i = 0; i < n; i++) {
                if (!visited[i]) {
                    int distance = Math.abs(points[pointIndex][0] - points[i][0]) + Math.abs(points[pointIndex][1] - points[i][1]);
                    pq.offer(new int[]{distance, i});
                }
            }
        }
        return cost;
    }
}