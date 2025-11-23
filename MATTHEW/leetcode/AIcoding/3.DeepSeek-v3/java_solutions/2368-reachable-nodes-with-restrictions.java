class Solution {
    public int reachableNodes(int n, int[][] edges, int[] restricted) {
        Set<Integer> restrictedSet = new HashSet<>();
        for (int num : restricted) {
            restrictedSet.add(num);
        }

        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        boolean[] visited = new boolean[n];
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(0);
        visited[0] = true;
        int count = 0;

        while (!queue.isEmpty()) {
            int current = queue.poll();
            count++;

            for (int neighbor : graph.get(current)) {
                if (!visited[neighbor] && !restrictedSet.contains(neighbor)) {
                    visited[neighbor] = true;
                    queue.offer(neighbor);
                }
            }
        }

        return count;
    }
}