class Graph {
    private List<List<int[]>> adjList;

    public Graph(int n, int[][] edges) {
        adjList = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adjList.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adjList.get(edge[0]).add(new int[]{edge[1], edge[2]});
        }
    }

    public void addEdge(int[] edge) {
        adjList.get(edge[0]).add(new int[]{edge[1], edge[2]});
    }

    public int shortestPath(int node1, int node2) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        int[] dist = new int[adjList.size()];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[node1] = 0;
        pq.offer(new int[]{node1, 0});

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int node = current[0];
            int currentDist = current[1];

            if (node == node2) {
                return currentDist;
            }

            if (currentDist > dist[node]) {
                continue;
            }

            for (int[] neighbor : adjList.get(node)) {
                int nextNode = neighbor[0];
                int nextDist = currentDist + neighbor[1];
                if (nextDist < dist[nextNode]) {
                    dist[nextNode] = nextDist;
                    pq.offer(new int[]{nextNode, nextDist});
                }
            }
        }

        return -1;
    }
}