import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

class Solution {
    public int maximumDetonation(int[][] bombs) {
        int n = bombs.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i == j) {
                    continue;
                }

                long x1 = bombs[i][0];
                long y1 = bombs[i][1];
                long r1 = bombs[i][2];

                long x2 = bombs[j][0];
                long y2 = bombs[j][1];

                long distSq = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
                long r1Sq = r1 * r1;

                if (distSq <= r1Sq) {
                    adj.get(i).add(j);
                }
            }
        }

        int maxDetonated = 0;

        for (int i = 0; i < n; i++) {
            Queue<Integer> q = new LinkedList<>();
            boolean[] visited = new boolean[n];
            int currentDetonated = 0;

            q.offer(i);
            visited[i] = true;
            currentDetonated++;

            while (!q.isEmpty()) {
                int u = q.poll();

                for (int v : adj.get(u)) {
                    if (!visited[v]) {
                        visited[v] = true;
                        currentDetonated++;
                        q.offer(v);
                    }
                }
            }
            maxDetonated = Math.max(maxDetonated, currentDetonated);
        }

        return maxDetonated;
    }
}