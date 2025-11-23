public class Solution {

import java.util.*;

public class Solution {
    public int secondMinimum(int n, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] dist1 = new int[n + 1];
        int[] dist2 = new int[n + 1];
        Arrays.fill(dist1, Integer.MAX_VALUE);
        Arrays.fill(dist2, Integer.MAX_VALUE);

        Queue<int[]> queue = new LinkedList<>();
        queue.add(new int[]{1, 0});
        dist1[1] = 0;

        while (!queue.isEmpty()) {
            int[] node = queue.poll();
            int u = node[0];
            int d = node[1];

            for (int v : graph.get(u)) {
                if (dist1[v] > d + 1) {
                    int temp = dist1[v];
                    dist1[v] = d + 1;
                    queue.add(new int[]{v, d + 1});
                    if (temp != Integer.MAX_VALUE) {
                        dist2[v] = temp;
                    }
                } else if (dist1[v] < d + 1 && dist2[v] > d + 1) {
                    dist2[v] = d + 1;
                    queue.add(new int[]{v, d + 1});
                }
            }
        }

        return dist2[n] == Integer.MAX_VALUE ? -1 : dist2[n];
    }
}
}