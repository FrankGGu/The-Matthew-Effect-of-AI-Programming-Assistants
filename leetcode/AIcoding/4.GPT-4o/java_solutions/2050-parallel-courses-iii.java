import java.util.*;

public class Solution {
    public int minimumTime(int n, int[][] relations, int[] time) {
        int[] inDegree = new int[n + 1];
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] relation : relations) {
            int u = relation[0], v = relation[1];
            graph.get(u).add(v);
            inDegree[v]++;
        }

        int[] dp = new int[n + 1];
        Queue<Integer> queue = new LinkedList<>();

        for (int i = 1; i <= n; i++) {
            if (inDegree[i] == 0) {
                dp[i] = time[i - 1];
                queue.offer(i);
            }
        }

        while (!queue.isEmpty()) {
            int u = queue.poll();
            for (int v : graph.get(u)) {
                dp[v] = Math.max(dp[v], dp[u] + time[v - 1]);
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    queue.offer(v);
                }
            }
        }

        int result = 0;
        for (int i = 1; i <= n; i++) {
            result = Math.max(result, dp[i]);
        }

        return result;
    }
}