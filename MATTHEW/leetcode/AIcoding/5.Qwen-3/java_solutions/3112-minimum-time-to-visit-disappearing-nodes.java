public class Solution {

import java.util.*;

public class Solution {
    public int[] minTimeToVisitDisappearingNodes(int[][] edges, int[] nodeTime, int start) {
        int n = nodeTime.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        int[] result = new int[n];
        Arrays.fill(result, -1);
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
        pq.offer(new int[]{0, start});
        boolean[] visited = new boolean[n];

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int time = curr[0], node = curr[1];
            if (visited[node]) continue;
            visited[node] = true;
            result[node] = time;
            for (int neighbor : graph.get(node)) {
                if (!visited[neighbor]) {
                    pq.offer(new int[]{time + nodeTime[neighbor], neighbor});
                }
            }
        }

        return result;
    }
}
}