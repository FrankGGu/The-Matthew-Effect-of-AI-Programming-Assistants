class Solution {
    public int collectTheCoins(int[] coins, int[][] edges) {
        int n = coins.length;
        boolean[] visited = new boolean[n];
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        int[] leaves = new int[n];
        Arrays.fill(leaves, 1);

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (coins[i] == 0) {
                queue.offer(i);
                visited[i] = true;
            }
        }

        while (!queue.isEmpty()) {
            int curr = queue.poll();
            for (int neighbor : graph.get(curr)) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    leaves[neighbor] = 0;
                    queue.offer(neighbor);
                }
            }
        }

        int start = -1;
        for (int i = 0; i < n; i++) {
            if (coins[i] == 1 && leaves[i] == 1) {
                start = i;
                break;
            }
        }

        if (start == -1) return 0;

        int result = 0;
        visited = new boolean[n];
        queue.offer(start);
        visited[start] = true;

        while (!queue.isEmpty()) {
            int curr = queue.poll();
            for (int neighbor : graph.get(curr)) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    if (leaves[neighbor] == 1) {
                        result += 2;
                    }
                    queue.offer(neighbor);
                }
            }
        }

        return result;
    }
}