import java.util.*;

class Graph {
    private final Map<Integer, List<int[]>> graph;

    public Graph(int n) {
        graph = new HashMap<>();
        for (int i = 0; i < n; i++) {
            graph.put(i, new ArrayList<>());
        }
    }

    public void addEdge(int u, int v, int weight) {
        graph.get(u).add(new int[]{v, weight});
        graph.get(v).add(new int[]{u, weight});
    }

    public int[] shortestPath(int startNode) {
        int n = graph.size();
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[startNode] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{startNode, 0});

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int node = current[0];
            int currentDist = current[1];

            if (currentDist > dist[node]) continue;

            for (int[] neighbor : graph.get(node)) {
                int nextNode = neighbor[0];
                int weight = neighbor[1];
                if (currentDist + weight < dist[nextNode]) {
                    dist[nextNode] = currentDist + weight;
                    pq.offer(new int[]{nextNode, dist[nextNode]});
                }
            }
        }
        return dist;
    }
}

class Solution {
    private final Map<Integer, Graph> graphs;

    public Solution() {
        graphs = new HashMap<>();
    }

    public void addGraph(int n) {
        graphs.put(n, new Graph(n));
    }

    public void addEdge(int n, int u, int v, int weight) {
        graphs.get(n).addEdge(u, v, weight);
    }

    public int[] shortestPath(int n, int startNode) {
        return graphs.get(n).shortestPath(startNode);
    }
}