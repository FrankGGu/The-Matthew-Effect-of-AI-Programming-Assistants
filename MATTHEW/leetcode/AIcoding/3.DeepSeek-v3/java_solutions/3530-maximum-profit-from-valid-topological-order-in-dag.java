import java.util.*;

class Solution {
    public int maxProfit(int[] profit, int[][] edges) {
        int n = profit.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        int[] inDegree = new int[n];
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            graph.get(u).add(v);
            inDegree[v]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        int[] maxProfit = new int[n];
        for (int i = 0; i < n; i++) {
            maxProfit[i] = profit[i];
            if (inDegree[i] == 0) {
                queue.offer(i);
            }
        }

        int result = 0;
        while (!queue.isEmpty()) {
            int u = queue.poll();
            result = Math.max(result, maxProfit[u]);
            for (int v : graph.get(u)) {
                maxProfit[v] = Math.max(maxProfit[v], maxProfit[u] + profit[v]);
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    queue.offer(v);
                }
            }
        }
        return result;
    }
}