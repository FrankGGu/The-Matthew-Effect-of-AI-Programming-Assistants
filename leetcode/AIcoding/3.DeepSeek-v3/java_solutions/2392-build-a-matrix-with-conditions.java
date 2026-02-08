class Solution {
    public int[][] buildMatrix(int k, int[][] rowConditions, int[][] colConditions) {
        List<Integer> rowOrder = topologicalSort(k, rowConditions);
        List<Integer> colOrder = topologicalSort(k, colConditions);

        if (rowOrder == null || colOrder == null) {
            return new int[0][0];
        }

        int[][] result = new int[k][k];
        Map<Integer, Integer> rowPos = new HashMap<>();
        Map<Integer, Integer> colPos = new HashMap<>();

        for (int i = 0; i < k; i++) {
            rowPos.put(rowOrder.get(i), i);
            colPos.put(colOrder.get(i), i);
        }

        for (int num = 1; num <= k; num++) {
            int row = rowPos.get(num);
            int col = colPos.get(num);
            result[row][col] = num;
        }

        return result;
    }

    private List<Integer> topologicalSort(int k, int[][] conditions) {
        List<Integer>[] graph = new List[k + 1];
        for (int i = 1; i <= k; i++) {
            graph[i] = new ArrayList<>();
        }

        int[] inDegree = new int[k + 1];
        for (int[] cond : conditions) {
            int u = cond[0];
            int v = cond[1];
            graph[u].add(v);
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
            for (int v : graph[u]) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    queue.offer(v);
                }
            }
        }

        if (order.size() != k) {
            return null;
        }
        return order;
    }
}