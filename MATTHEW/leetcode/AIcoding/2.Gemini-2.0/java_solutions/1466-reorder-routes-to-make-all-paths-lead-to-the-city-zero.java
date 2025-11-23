import java.util.*;

class Solution {
    public int minReorder(int n, int[][] connections) {
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] connection : connections) {
            adj.get(connection[0]).add(new int[]{connection[1], 1});
            adj.get(connection[1]).add(new int[]{connection[0], 0});
        }

        Queue<Integer> queue = new LinkedList<>();
        queue.offer(0);
        boolean[] visited = new boolean[n];
        visited[0] = true;
        int count = 0;

        while (!queue.isEmpty()) {
            int u = queue.poll();
            for (int[] neighbor : adj.get(u)) {
                int v = neighbor[0];
                int dir = neighbor[1];
                if (!visited[v]) {
                    visited[v] = true;
                    count += dir;
                    queue.offer(v);
                }
            }
        }

        return count;
    }
}