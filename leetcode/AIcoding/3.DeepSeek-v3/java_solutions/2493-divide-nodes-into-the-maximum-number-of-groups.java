class Solution {
    public int magnificentSets(int n, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        int[] visited = new int[n + 1];
        int res = 0;
        for (int i = 1; i <= n; i++) {
            if (visited[i] == 0) {
                List<Integer> component = new ArrayList<>();
                dfs(i, graph, visited, component);
                int maxGroups = -1;
                for (int node : component) {
                    int groups = bfs(node, graph, component);
                    if (groups == -1) {
                        return -1;
                    }
                    maxGroups = Math.max(maxGroups, groups);
                }
                res += maxGroups;
            }
        }
        return res;
    }

    private void dfs(int node, List<List<Integer>> graph, int[] visited, List<Integer> component) {
        visited[node] = 1;
        component.add(node);
        for (int neighbor : graph.get(node)) {
            if (visited[neighbor] == 0) {
                dfs(neighbor, graph, visited, component);
            }
        }
    }

    private int bfs(int start, List<List<Integer>> graph, List<Integer> component) {
        Set<Integer> componentSet = new HashSet<>(component);
        Queue<Integer> queue = new LinkedList<>();
        int[] level = new int[componentSet.size() + 1];
        Arrays.fill(level, -1);
        level[start] = 1;
        queue.offer(start);

        int maxLevel = 1;
        while (!queue.isEmpty()) {
            int current = queue.poll();
            for (int neighbor : graph.get(current)) {
                if (componentSet.contains(neighbor)) {
                    if (level[neighbor] == -1) {
                        level[neighbor] = level[current] + 1;
                        maxLevel = Math.max(maxLevel, level[neighbor]);
                        queue.offer(neighbor);
                    } else if (Math.abs(level[neighbor] - level[current]) != 1) {
                        return -1;
                    }
                }
            }
        }
        return maxLevel;
    }
}