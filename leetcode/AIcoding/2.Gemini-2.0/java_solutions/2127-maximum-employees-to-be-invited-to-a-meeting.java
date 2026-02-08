import java.util.*;

class Solution {
    public int maximumInvitations(int[] favorites) {
        int n = favorites.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        int[] indegree = new int[n];
        for (int i = 0; i < n; i++) {
            adj.get(favorites[i]).add(i);
            indegree[i]++;
        }

        Queue<Integer> q = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (indegree[i] == 0) {
                q.offer(i);
            }
        }

        int[] depth = new int[n];
        Arrays.fill(depth, 1);
        while (!q.isEmpty()) {
            int u = q.poll();
            for (int v : adj.get(u)) {
                indegree[v]--;
                depth[v] = Math.max(depth[v], depth[u] + 1);
                if (indegree[v] == 0) {
                    q.offer(v);
                }
            }
        }

        int cycleSum = 0;
        int maxCycleLen = 0;
        boolean[] visited = new boolean[n];
        for (int i = 0; i < n; i++) {
            if (!visited[i] && indegree[i] > 0) {
                int cycleLen = 0;
                int curr = i;
                while (!visited[curr]) {
                    visited[curr] = true;
                    curr = favorites[curr];
                    cycleLen++;
                }
                maxCycleLen += cycleLen;
            } else if (indegree[i] > 0) {
                visited[i] = true;
            }
        }

        int linearSum = 0;
        for (int i = 0; i < n; i++) {
            if (favorites[favorites[i]] == i) {
                linearSum += depth[i] + depth[favorites[i]];
                favorites[i] = -1;
            }
        }

        return Math.max(maxCycleLen, linearSum / 2);
    }
}