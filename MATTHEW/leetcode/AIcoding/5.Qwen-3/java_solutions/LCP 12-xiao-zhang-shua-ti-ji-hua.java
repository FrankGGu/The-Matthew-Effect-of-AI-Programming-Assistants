public class Solution {

import java.util.*;

public class Solution {
    public int[] completeThePlan(int n, int[][] plans) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        int[] inDegree = new int[n];

        for (int[] plan : plans) {
            int from = plan[0];
            int to = plan[1];
            int time = plan[2];
            graph.putIfAbsent(from, new ArrayList<>());
            graph.get(from).add(new int[]{to, time});
            inDegree[to]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        int[] result = new int[n];
        int[] maxTime = new int[n];

        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                queue.offer(i);
                maxTime[i] = 0;
            }
        }

        while (!queue.isEmpty()) {
            int current = queue.poll();
            for (int[] next : graph.getOrDefault(current, new ArrayList<>())) {
                int node = next[0];
                int time = next[1];
                maxTime[node] = Math.max(maxTime[node], maxTime[current] + time);
                inDegree[node]--;
                if (inDegree[node] == 0) {
                    queue.offer(node);
                }
            }
        }

        for (int i = 0; i < n; i++) {
            result[i] = maxTime[i];
        }

        return result;
    }
}
}