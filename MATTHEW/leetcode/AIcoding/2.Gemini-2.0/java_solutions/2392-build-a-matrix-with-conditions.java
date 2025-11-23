import java.util.*;

class Solution {
    public int[][] buildMatrix(int k, int[][] rowConditions, int[][] colConditions) {
        List<Integer>[] rowGraph = new List[k];
        List<Integer>[] colGraph = new List[k];
        int[] rowInDegree = new int[k];
        int[] colInDegree = new int[k];

        for (int i = 0; i < k; i++) {
            rowGraph[i] = new ArrayList<>();
            colGraph[i] = new ArrayList<>();
        }

        for (int[] condition : rowConditions) {
            rowGraph[condition[1] - 1].add(condition[0] - 1);
            rowInDegree[condition[0] - 1]++;
        }

        for (int[] condition : colConditions) {
            colGraph[condition[1] - 1].add(condition[0] - 1);
            colInDegree[condition[0] - 1]++;
        }

        List<Integer> rowOrder = topologicalSort(rowGraph, rowInDegree, k);
        List<Integer> colOrder = topologicalSort(colGraph, colInDegree, k);

        if (rowOrder.size() != k || colOrder.size() != k) {
            return new int[0][0];
        }

        int[][] result = new int[k][k];
        Map<Integer, Integer> colMap = new HashMap<>();
        for (int i = 0; i < k; i++) {
            colMap.put(colOrder.get(i), i);
        }

        for (int i = 0; i < k; i++) {
            result[i][colMap.get(rowOrder.get(i))] = rowOrder.get(i) + 1;
        }

        return result;
    }

    private List<Integer> topologicalSort(List<Integer>[] graph, int[] inDegree, int k) {
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < k; i++) {
            if (inDegree[i] == 0) {
                queue.offer(i);
            }
        }

        List<Integer> result = new ArrayList<>();
        while (!queue.isEmpty()) {
            int node = queue.poll();
            result.add(node);

            for (int neighbor : graph[node]) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    queue.offer(neighbor);
                }
            }
        }

        return result;
    }
}