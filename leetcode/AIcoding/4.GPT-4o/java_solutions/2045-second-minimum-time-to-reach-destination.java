import java.util.PriorityQueue;

public class Solution {
    public int secondMinimum(int n, int[][] edges, int time, int change) {
        long[][] graph = new long[n + 1][n + 1];
        for (int[] edge : edges) {
            graph[edge[0]][edge[1]] = graph[edge[1]][edge[0]] = 1;
        }

        long[][] minTime = new long[n + 1][2];
        for (int i = 1; i <= n; i++) {
            minTime[i][0] = Long.MAX_VALUE;
            minTime[i][1] = Long.MAX_VALUE;
        }
        minTime[1][0] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> Long.compare(a[0], b[0]));
        pq.offer(new int[]{0, 1, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            long currTime = curr[0], node = curr[1], state = curr[2];

            if (node == n && state == 1) {
                return (int) currTime;
            }

            for (int next = 1; next <= n; next++) {
                if (graph[node][next] == 1) {
                    long waitTime = ((currTime / change) + 1) * change - currTime;
                    long newTime = currTime + (waitTime > 0 ? waitTime : 0) + time;
                    if (newTime < minTime[next][state]) {
                        minTime[next][state] = newTime;
                        pq.offer(new int[]{(int) newTime, next, state});
                    }
                    if (state == 0 && newTime < minTime[next][1]) {
                        minTime[next][1] = newTime;
                        pq.offer(new int[]{(int) newTime, next, 1});
                    }
                }
            }
        }
        return -1;
    }
}