public class Solution {

import java.util.*;

public class Solution {
    public double maxProbability(int n, int[][] edges, double[] succProb, int start, int end) {
        Map<Integer, List<double[]>> graph = new HashMap<>();
        for (int i = 0; i < n; i++) {
            graph.put(i, new ArrayList<>());
        }
        for (int i = 0; i < edges.length; i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            graph.get(u).add(new double[]{v, succProb[i]});
            graph.get(v).add(new double[]{u, succProb[i]});
        }

        double[] prob = new double[n];
        Arrays.fill(prob, 0.0);
        prob[start] = 1.0;

        PriorityQueue<double[]> pq = new PriorityQueue<>((a, b) -> Double.compare(b[1], a[1]));
        pq.offer(new double[]{start, 1.0});

        while (!pq.isEmpty()) {
            double[] curr = pq.poll();
            int node = (int) curr[0];
            double currentProb = curr[1];

            if (node == end) {
                return currentProb;
            }

            if (currentProb < prob[node]) {
                continue;
            }

            for (double[] neighbor : graph.get(node)) {
                int nextNode = (int) neighbor[0];
                double edgeProb = neighbor[1];
                double newProb = currentProb * edgeProb;
                if (newProb > prob[nextNode]) {
                    prob[nextNode] = newProb;
                    pq.offer(new double[]{nextNode, newProb});
                }
            }
        }

        return 0.0;
    }
}
}