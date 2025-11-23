import java.util.*;

class Solution {
    public double maxProbability(int n, int[][] edges, double[] succProb, int start, int end) {
        List<List<double[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int i = 0; i < edges.length; i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            double prob = succProb[i];
            adj.get(u).add(new double[]{(double) v, prob});
            adj.get(v).add(new double[]{(double) u, prob});
        }

        double[] maxProb = new double[n];
        maxProb[start] = 1.0;

        // PriorityQueue stores pairs of [probability, node]
        // Ordered by probability in descending order
        PriorityQueue<double[]> pq = new PriorityQueue<>((a, b) -> Double.compare(b[0], a[0]));
        pq.offer(new double[]{1.0, (double) start});

        while (!pq.isEmpty()) {
            double[] current = pq.poll();
            double currentProb = current[0];
            int u = (int) current[1];

            if (currentProb < maxProb[u]) {
                continue;
            }

            if (u == end) {
                return currentProb;
            }

            for (double[] neighbor : adj.get(u)) {
                int v = (int) neighbor[0];
                double edgeProb = neighbor[1];

                if (maxProb[u] * edgeProb > maxProb[v]) {
                    maxProb[v] = maxProb[u] * edgeProb;
                    pq.offer(new double[]{maxProb[v], (double) v});
                }
            }
        }

        return maxProb[end];
    }
}