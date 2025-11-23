class Solution {
    public int[][] modifiedGraphEdges(int n, int[][] edges, int source, int destination, int target) {
        List<int[]>[] graph = new ArrayList[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int i = 0; i < edges.length; i++) {
            int u = edges[i][0], v = edges[i][1], w = edges[i][2];
            graph[u].add(new int[]{v, i});
            graph[v].add(new int[]{u, i});
        }

        int[] distTo = new int[n];
        Arrays.fill(distTo, Integer.MAX_VALUE);
        distTo[source] = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        pq.offer(new int[]{source, 0});

        dijkstra(graph, edges, distTo, pq, false);

        if (distTo[destination] < target) {
            return new int[0][];
        }
        if (distTo[destination] == target) {
            for (int[] edge : edges) {
                if (edge[2] == -1) {
                    edge[2] = 1;
                }
            }
            return edges;
        }

        Arrays.fill(distTo, Integer.MAX_VALUE);
        distTo[source] = 0;
        pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        pq.offer(new int[]{source, 0});

        dijkstra(graph, edges, distTo, pq, true);

        if (distTo[destination] > target) {
            return new int[0][];
        }

        int remain = target - distTo[destination];
        for (int[] edge : edges) {
            if (edge[2] == -1) {
                if (remain > 0) {
                    edge[2] = 1 + remain;
                    remain = 0;
                } else {
                    edge[2] = 1;
                }
            }
        }
        return edges;
    }

    private void dijkstra(List<int[]>[] graph, int[][] edges, int[] distTo, PriorityQueue<int[]> pq, boolean modify) {
        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int u = curr[0], dist = curr[1];
            if (dist > distTo[u]) {
                continue;
            }
            for (int[] neighbor : graph[u]) {
                int v = neighbor[0], idx = neighbor[1];
                int w = edges[idx][2];
                if (w == -1) {
                    if (modify) {
                        w = 1;
                    } else {
                        continue;
                    }
                }
                if (distTo[v] > distTo[u] + w) {
                    distTo[v] = distTo[u] + w;
                    pq.offer(new int[]{v, distTo[v]});
                }
            }
        }
    }
}