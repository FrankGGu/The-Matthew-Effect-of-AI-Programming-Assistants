import java.util.*;

class Solution {
    public double maxProbability(int n, int[][] edges, double[] succProb, int start, int end) {
        List<List<Pair>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int i = 0; i < edges.length; i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            double prob = succProb[i];
            adj.get(u).add(new Pair(v, prob));
            adj.get(v).add(new Pair(u, prob));
        }

        double[] maxProb = new double[n];
        maxProb[start] = 1.0;

        PriorityQueue<Pair> pq = new PriorityQueue<>((a, b) -> Double.compare(b.prob, a.prob));
        pq.offer(new Pair(start, 1.0));

        while (!pq.isEmpty()) {
            Pair curr = pq.poll();
            int u = curr.node;
            double prob = curr.prob;

            if (prob < maxProb[u]) {
                continue;
            }

            for (Pair neighbor : adj.get(u)) {
                int v = neighbor.node;
                double edgeProb = neighbor.prob;

                if (maxProb[u] * edgeProb > maxProb[v]) {
                    maxProb[v] = maxProb[u] * edgeProb;
                    pq.offer(new Pair(v, maxProb[v]));
                }
            }
        }

        return maxProb[end];
    }

    private static class Pair {
        int node;
        double prob;

        public Pair(int node, double prob) {
            this.node = node;
            this.prob = prob;
        }
    }
}