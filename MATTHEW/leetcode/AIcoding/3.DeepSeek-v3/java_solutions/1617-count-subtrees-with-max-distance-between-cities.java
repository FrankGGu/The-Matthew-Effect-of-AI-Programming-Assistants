class Solution {
    public int[] countSubgraphsForEachDiameter(int n, int[][] edges) {
        List<Integer>[] graph = new List[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0] - 1;
            int v = edge[1] - 1;
            graph[u].add(v);
            graph[v].add(u);
        }

        int[] res = new int[n - 1];
        for (int mask = 1; mask < (1 << n); mask++) {
            int d = maxDistance(mask, graph);
            if (d > 0) {
                res[d - 1]++;
            }
        }
        return res;
    }

    private int maxDistance(int mask, List<Integer>[] graph) {
        int maxDist = -1;
        int n = graph.length;
        for (int i = 0; i < n; i++) {
            if ((mask & (1 << i)) != 0) {
                int dist = bfs(i, mask, graph);
                if (dist > maxDist) {
                    maxDist = dist;
                }
            }
        }
        return maxDist;
    }

    private int bfs(int start, int mask, List<Integer>[] graph) {
        int n = graph.length;
        Queue<Integer> queue = new LinkedList<>();
        boolean[] visited = new boolean[n];
        queue.offer(start);
        visited[start] = true;
        int lastNode = start;
        int dist = -1;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int node = queue.poll();
                lastNode = node;
                for (int neighbor : graph[node]) {
                    if (!visited[neighbor] && (mask & (1 << neighbor)) != 0) {
                        visited[neighbor] = true;
                        queue.offer(neighbor);
                    }
                }
            }
            dist++;
        }

        for (int i = 0; i < n; i++) {
            if ((mask & (1 << i)) != 0 && !visited[i]) {
                return -1;
            }
        }

        queue = new LinkedList<>();
        visited = new boolean[n];
        queue.offer(lastNode);
        visited[lastNode] = true;
        dist = -1;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int node = queue.poll();
                for (int neighbor : graph[node]) {
                    if (!visited[neighbor] && (mask & (1 << neighbor)) != 0) {
                        visited[neighbor] = true;
                        queue.offer(neighbor);
                    }
                }
            }
            dist++;
        }
        return dist;
    }
}