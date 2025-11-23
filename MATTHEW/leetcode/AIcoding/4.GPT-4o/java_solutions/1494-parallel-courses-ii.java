import java.util.*;

public class Solution {
    public int minimumTime(int n, int[][] relations, int[] time) {
        int[] indegree = new int[n + 1];
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int[] relation : relations) {
            int u = relation[0], v = relation[1];
            graph.get(u).add(v);
            indegree[v]++;
        }

        int[] dp = new int[n + 1];
        Queue<Integer> queue = new LinkedList<>();

        for (int i = 1; i <= n; i++) {
            if (indegree[i] == 0) {
                queue.offer(i);
                dp[i] = time[i - 1];
            }
        }

        while (!queue.isEmpty()) {
            int course = queue.poll();
            for (int next : graph.get(course)) {
                dp[next] = Math.max(dp[next], dp[course] + time[next - 1]);
                indegree[next]--;
                if (indegree[next] == 0) {
                    queue.offer(next);
                }
            }
        }

        int res = 0;
        for (int i = 1; i <= n; i++) {
            res = Math.max(res, dp[i]);
        }

        return res;
    }
}