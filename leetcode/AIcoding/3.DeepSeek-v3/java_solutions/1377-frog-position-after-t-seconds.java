class Solution {
    public double frogPosition(int n, int[][] edges, int t, int target) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }
        boolean[] visited = new boolean[n + 1];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{1, 1});
        visited[1] = true;
        int time = 0;
        while (!queue.isEmpty() && time <= t) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] current = queue.poll();
                int node = current[0];
                int probability = current[1];
                List<Integer> children = new ArrayList<>();
                for (int neighbor : graph.get(node)) {
                    if (!visited[neighbor]) {
                        children.add(neighbor);
                    }
                }
                if (node == target) {
                    if (time == t || children.isEmpty()) {
                        return 1.0 / probability;
                    } else {
                        return 0.0;
                    }
                }
                for (int child : children) {
                    visited[child] = true;
                    queue.offer(new int[]{child, probability * children.size()});
                }
            }
            time++;
        }
        return 0.0;
    }
}