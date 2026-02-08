import java.util.*;

class Solution {
    public int minimumTime(int n, int[][] relations, int[] time) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }

        int[] inDegree = new int[n + 1];
        for (int[] relation : relations) {
            int prevCourse = relation[0];
            int nextCourse = relation[1];
            adj.get(prevCourse).add(nextCourse);
            inDegree[nextCourse]++;
        }

        int[] finishTime = new int[n + 1];
        Queue<Integer> q = new LinkedList<>();

        for (int i = 1; i <= n; i++) {
            finishTime[i] = time[i - 1];
            if (inDegree[i] == 0) {
                q.offer(i);
            }
        }

        while (!q.isEmpty()) {
            int u = q.poll();

            for (int v : adj.get(u)) {
                finishTime[v] = Math.max(finishTime[v], finishTime[u] + time[v - 1]);
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.offer(v);
                }
            }
        }

        int maxTotalTime = 0;
        for (int i = 1; i <= n; i++) {
            maxTotalTime = Math.max(maxTotalTime, finishTime[i]);
        }

        return maxTotalTime;
    }
}