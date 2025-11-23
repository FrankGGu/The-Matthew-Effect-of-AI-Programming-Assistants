import java.util.*;

class Solution {
    public int[][] buildMatrix(int k, int[][] rowConditions, int[][] colConditions) {
        List<Integer> rowOrder = topologicalSort(k, rowConditions);
        List<Integer> colOrder = topologicalSort(k, colConditions);

        if (rowOrder.isEmpty() || colOrder.isEmpty()) {
            return new int[0][0];
        }

        int[] rowPos = new int[k + 1];
        for (int i = 0; i < k; i++) {
            rowPos[rowOrder.get(i)] = i;
        }

        int[] colPos = new int[k + 1];
        for (int i = 0; i < k; i++) {
            colPos[colOrder.get(i)] = i;
        }

        int[][] matrix = new int[k][k];
        for (int i = 1; i <= k; i++) {
            matrix[rowPos[i]][colPos[i]] = i;
        }

        return matrix;
    }

    private List<Integer> topologicalSort(int k, int[][] conditions) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i <= k; i++) {
            adj.add(new ArrayList<>());
        }

        int[] inDegree = new int[k + 1];
        for (int[] condition : conditions) {
            int u = condition[0];
            int v = condition[1];
            adj.get(u).add(v);
            inDegree[v]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 1; i <= k; i++) {
            if (inDegree[i] == 0) {
                queue.offer(i);
            }
        }

        List<Integer> order = new ArrayList<>();
        while (!queue.isEmpty()) {
            int u = queue.poll();
            order.add(u);

            for (int v : adj.get(u)) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    queue.offer(v);
                }
            }
        }

        if (order.size() == k) {
            return order;
        } else {
            return new ArrayList<>(); 
        }
    }
}