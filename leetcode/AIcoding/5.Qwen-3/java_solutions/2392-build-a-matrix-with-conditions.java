public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> buildMatrix(int k, int[][] rowConditions, int[][] colConditions) {
        List<Integer> rowOrder = topologicalSort(k, rowConditions);
        List<Integer> colOrder = topologicalSort(k, colConditions);

        if (rowOrder == null || colOrder == null) {
            return new ArrayList<>();
        }

        Map<Integer, Integer> rowMap = new HashMap<>();
        Map<Integer, Integer> colMap = new HashMap<>();

        for (int i = 0; i < k; i++) {
            rowMap.put(rowOrder.get(i), i);
            colMap.put(colOrder.get(i), i);
        }

        List<List<Integer>> matrix = new ArrayList<>();
        for (int i = 0; i < k; i++) {
            matrix.add(new ArrayList<>());
        }

        for (int i = 0; i < k; i++) {
            int row = rowMap.get(i);
            int col = colMap.get(i);
            matrix.get(row).add(i);
        }

        return matrix;
    }

    private List<Integer> topologicalSort(int n, int[][] edges) {
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
        for (int i = 0; i < n; i++) {
            if (inDegree[i] == 0) {
                queue.add(i);
            }
        }

        List<Integer> order = new ArrayList<>();

        while (!queue.isEmpty()) {
            int node = queue.poll();
            order.add(node);
            for (int neighbor : graph.get(node)) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    queue.add(neighbor);
                }
            }
        }

        if (order.size() != n) {
            return null;
        }

        return order;
    }
}
}