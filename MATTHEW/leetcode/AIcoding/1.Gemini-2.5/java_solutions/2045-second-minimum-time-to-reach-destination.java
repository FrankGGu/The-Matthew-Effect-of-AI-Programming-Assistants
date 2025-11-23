import java.util.*;

class Solution {
    public int secondMinimum(int n, int[][] edges, int time, int change) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        int[][] minTimes = new int[n + 1][2];
        for (int i = 0; i <= n; i++) {
            minTimes[i][0] = Integer.MAX_VALUE;
            minTimes[i][1] = Integer.MAX_VALUE;
        }

        Queue<int[]> q = new LinkedList<>(); // {node, current_time}

        minTimes[1][0] = 0;
        q.offer(new int[]{1, 0});

        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int u = curr[0];
            int t = curr[1];

            int cycleDuration = 2 * change;
            int numCycles = t / cycleDuration;
            int timeIntoCycle = t % cycleDuration;

            int departureTimeFromU;
            if (timeIntoCycle < change) { // Green light
                departureTimeFromU = t + time;
            } else { // Red light, wait for next green
                departureTimeFromU = (numCycles + 1) * cycleDuration + time;
            }

            for (int v : adj.get(u)) {
                int newTime = departureTimeFromU;

                if (newTime < minTimes[v][0]) {
                    minTimes[v][1] = minTimes[v][0];
                    minTimes[v][0] = newTime;
                    q.offer(new int[]{v, newTime});
                } else if (newTime > minTimes[v][0] && newTime < minTimes[v][1]) {
                    minTimes[v][1] = newTime;
                    q.offer(new int[]{v, newTime});
                }
            }
        }

        return minTimes[n][1];
    }
}