import java.util.*;

class Solution {
    static final long INF = Long.MAX_VALUE;

    static class Edge {
        int to;
        long capacity;
        long cost;
        int rev; // index of reverse edge in 'to' node's adj list

        Edge(int to, long capacity, long cost, int rev) {
            this.to = to;
            this.capacity = capacity;
            this.cost = cost;
            this.rev = rev;
        }
    }

    static class MinCostMaxFlow {
        int V;
        List<List<Edge>> adj;
        long[] potential; // potentials for Dijkstra
        long[] dist; // distance for Dijkstra
        int[] prevV, prevE; // previous vertex and edge in shortest path

        MinCostMaxFlow(int V) {
            this.V = V;
            adj = new ArrayList<>(V);
            for (int i = 0; i < V; i++) {
                adj.add(new ArrayList<>());
            }
            potential = new long[V];
            dist = new long[V];
            prevV = new int[V];
            prevE = new int[V];
        }

        void addEdge(int from, int to, long capacity, long cost) {
            adj.get(from).add(new Edge(to, capacity, cost, adj.get(to).size()));
            adj.get(to).add(new Edge(from, 0, -cost, adj.get(from).size() - 1)); // Residual edge
        }

        // Dijkstra to find shortest path from s to t
        boolean shortestPath(int s, int t) {
            Arrays.fill(dist, INF);
            Arrays.fill(prevV, -1);
            Arrays.fill(prevE, -1);
            dist[s] = 0;

            PriorityQueue<long[]> pq = new PriorityQueue<>(Comparator.comparingLong(a -> a[0]));
            pq.offer(new long[]{0, s}); // {distance, vertex}

            while (!pq.isEmpty()) {
                long d = pq.peek()[0];
                int v = (int) pq.poll()[1];

                if (d > dist[v]) continue;

                for (int i = 0; i < adj.get(v).size(); i++) {
                    Edge e = adj.get(v).get(i);
                    if (e.capacity > 0 && dist[e.to] > dist[v] + e.cost + potential[v] - potential[e.to]) {
                        dist[e.to] = dist[v] + e.cost + potential[v] - potential[e.to];
                        prevV[e.to] = v;
                        prevE[e.to] = i;
                        pq.offer(new long[]{dist[e.to], e.to});
                    }
                }
            }
            return dist[t] != INF;
        }

        long[] minCostMaxFlow(int s, int t, long flowLimit) {
            long totalFlow = 0;
            long minCost = 0;

            while (totalFlow < flowLimit && shortestPath(s, t)) {
                // Update potentials
                for (int i = 0; i < V; i++) {
                    if (dist[i] != INF) {
                        potential[i] += dist[i];
                    }
                }

                long pathFlow = flowLimit - totalFlow;
                for (int v = t; v != s; v = prevV[v]) {
                    pathFlow = Math.min(pathFlow, adj.get(prevV[v]).get(prevE[v]).capacity);
                }

                totalFlow += pathFlow;
                for (int v = t; v != s; v = prevV[v]) {
                    Edge e = adj.get(prevV[v]).get(prevE[v]);
                    e.capacity -= pathFlow;
                    adj.get(e.to).get(e.rev).capacity += pathFlow;
                    minCost += pathFlow * e.cost;
                }
            }
            return new long[]{totalFlow, minCost};
        }
    }

    public long solve(int n, int[] volunteers, int[][] operations, int[] targets) {
        long totalInitialVolunteers = 0;
        long totalTargets = 0;
        for (int i = 0; i < n; i++) {
            totalInitialVolunteers += volunteers[i];
            totalTargets += targets[i];
        }

        if (totalInitialVolunteers < totalTargets) {
            return -1;
        }

        int S = 0, T = 1;
        int cityNodeOffset = 2; // Nodes 2 to N+1 are for cities
        int globalPoolNode = n + 2; // Node N+2 is the global pool

        int V = n + 3; // Total nodes: S, T, N cities, GlobalPool
        MinCostMaxFlow mcmf = new MinCostMaxFlow(V);

        long requiredFlow = 0;

        for (int i = 0; i < n; i++) {
            long initialSurplus = Math.max(0L, volunteers[i] - targets[i]);
            long initialDeficit = Math.max(0L, targets[i] - volunteers[i]);

            // Edge from S to city_node (free surplus)
            if (initialSurplus > 0) {
                mcmf.addEdge(S, cityNodeOffset + i, initialSurplus, 0);
            }

            // Edge from city_node to T (deficit)
            if (initialDeficit > 0) {
                mcmf.addEdge(cityNodeOffset + i, T, initialDeficit, 0);
                requiredFlow += initialDeficit;
            }

            // Edge from city_node to GlobalPool
            mcmf.addEdge(cityNodeOffset + i, globalPoolNode, INF, 0);

            // Edge from GlobalPool to city_node
            mcmf.addEdge(globalPoolNode, cityNodeOffset + i, INF, 0);
        }

        // Add operations
        for (int[] op : operations) {
            int idx = op[0];
            long k = op[1];
            long c = op[2];
            mcmf.addEdge(S, cityNodeOffset + idx, k, c);
        }

        long[] result = mcmf.minCostMaxFlow(S, T, requiredFlow);

        if (result[0] < requiredFlow) {
            return -1; // Not all targets can be met
        } else {
            return result[1];
        }
    }
}