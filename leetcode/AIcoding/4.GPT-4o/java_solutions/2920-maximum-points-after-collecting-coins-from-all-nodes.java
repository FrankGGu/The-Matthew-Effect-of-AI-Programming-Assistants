class Solution {
    public int collectTheCoins(int[] coins, int[][] edges) {
        int n = coins.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] degree = new int[n];
        for (int[] edge : edges) {
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (coins[i] == 0) {
                queue.offer(i);
            }
        }

        while (!queue.isEmpty()) {
            int node = queue.poll();
            for (int neighbor : graph.get(node)) {
                degree[neighbor]--;
                if (degree[neighbor] == 1 && coins[neighbor] == 0) {
                    queue.offer(neighbor);
                }
            }
        }

        int leafCount = 0;
        for (int i = 0; i < n; i++) {
            if (degree[i] > 0) {
                leafCount++;
            }
        }

        if (leafCount == 0) return 0;
        if (leafCount == 1) return 1;

        return leafCount + (leafCount > 2 ? -2 : 0);
    }
}