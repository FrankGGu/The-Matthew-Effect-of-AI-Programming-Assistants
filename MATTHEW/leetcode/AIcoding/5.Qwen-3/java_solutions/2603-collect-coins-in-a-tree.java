public class Solution {

import java.util.*;

class Solution {
    public int collectCoins(int[][] edges, int n) {
        if (n == 1) return 0;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] degree = new int[n];
        for (int i = 0; i < n; i++) {
            degree[i] = graph.get(i).size();
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (degree[i] == 1) {
                queue.add(i);
            }
        }

        int remainingNodes = n;
        while (!queue.isEmpty()) {
            int node = queue.poll();
            for (int neighbor : graph.get(node)) {
                if (degree[neighbor] > 1) {
                    degree[neighbor]--;
                    if (degree[neighbor] == 1) {
                        queue.add(neighbor);
                    }
                }
            }
            remainingNodes--;
        }

        if (remainingNodes <= 0) return 0;
        return remainingNodes - 1;
    }
}
}