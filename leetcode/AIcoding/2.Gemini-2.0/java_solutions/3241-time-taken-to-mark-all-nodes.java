import java.util.*;

class Solution {
    public int[] timeTaken(int[] arr, int[][] edges) {
        int n = arr.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] result = new int[n];
        boolean[] visited = new boolean[n];
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        pq.offer(new int[]{arr[0], 0});
        result[0] = arr[0];
        visited[0] = true;

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int time = curr[0];
            int node = curr[1];

            for (int neighbor : adj.get(node)) {
                if (!visited[neighbor]) {
                    int neighborTime = Math.max(time + 1, arr[neighbor]);
                    result[neighbor] = neighborTime;
                    pq.offer(new int[]{neighborTime, neighbor});
                    visited[neighbor] = true;
                }
            }
        }

        return result;
    }
}