import java.util.*;

class Solution {
    public int electricCarPlan(int[][] paths, int cnt, int start, int end, int[] charge) {
        int n = charge.length;
        List<int[]>[] graph = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] path : paths) {
            int u = path[0], v = path[1], w = path[2];
            graph[u].add(new int[]{v, w});
            graph[v].add(new int[]{u, w});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        int[][] dist = new int[n][cnt + 1];
        for (int[] row : dist) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        dist[start][0] = 0;
        pq.offer(new int[]{0, start, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int time = curr[0], u = curr[1], power = curr[2];
            if (u == end) {
                return time;
            }
            if (time > dist[u][power]) {
                continue;
            }
            for (int[] neighbor : graph[u]) {
                int v = neighbor[0], w = neighbor[1];
                if (power >= w) {
                    if (dist[v][power - w] > time + w) {
                        dist[v][power - w] = time + w;
                        pq.offer(new int[]{time + w, v, power - w});
                    }
                }
            }
            if (power < cnt) {
                int newPower = power + 1;
                int newTime = time + charge[u];
                if (dist[u][newPower] > newTime) {
                    dist[u][newPower] = newTime;
                    pq.offer(new int[]{newTime, u, newPower});
                }
            }
        }
        return -1;
    }
}