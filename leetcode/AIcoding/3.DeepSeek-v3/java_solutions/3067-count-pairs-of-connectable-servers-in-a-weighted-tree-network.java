class Solution {
    public int[] countPairsOfConnectableServers(int[][] edges, int signalSpeed) {
        int n = edges.length + 1;
        List<int[]>[] graph = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph[u].add(new int[]{v, w});
            graph[v].add(new int[]{u, w});
        }

        int[] res = new int[n];
        for (int c = 0; c < n; c++) {
            if (graph[c].size() < 2) continue;
            List<Integer> counts = new ArrayList<>();
            for (int[] neighbor : graph[c]) {
                int count = dfs(neighbor[0], c, neighbor[1], graph, signalSpeed);
                counts.add(count);
            }
            int total = 0;
            int sum = 0;
            for (int cnt : counts) {
                total += sum * cnt;
                sum += cnt;
            }
            res[c] = total;
        }
        return res;
    }

    private int dfs(int node, int parent, int dist, List<int[]>[] graph, int signalSpeed) {
        int count = (dist % signalSpeed == 0) ? 1 : 0;
        for (int[] neighbor : graph[node]) {
            int next = neighbor[0], w = neighbor[1];
            if (next != parent) {
                count += dfs(next, node, dist + w, graph, signalSpeed);
            }
        }
        return count;
    }
}