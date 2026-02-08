import java.util.*;

class Solution {
    public double maxProbability(int n, int[][] edges, double[] succProb, int start, int end) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int i = 0; i < edges.length; i++) {
            graph.putIfAbsent(edges[i][0], new ArrayList<>());
            graph.putIfAbsent(edges[i][1], new ArrayList<>());
            graph.get(edges[i][0]).add(new int[]{edges[i][1], (int)(succProb[i] * 100000)});
            graph.get(edges[i][1]).add(new int[]{edges[i][0], (int)(succProb[i] * 100000)});
        }

        double[] maxProb = new double[n];
        maxProb[start] = 1.0;
        PriorityQueue<double[]> pq = new PriorityQueue<>((a, b) -> Double.compare(b[1], a[1]));
        pq.offer(new double[]{start, 1.0});

        while (!pq.isEmpty()) {
            double[] curr = pq.poll();
            int node = (int) curr[0];
            double prob = curr[1];

            if (node == end) {
                return prob;
            }

            for (int[] neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                int nextNode = neighbor[0];
                double nextProb = prob * neighbor[1] / 100000.0;

                if (nextProb > maxProb[nextNode]) {
                    maxProb[nextNode] = nextProb;
                    pq.offer(new double[]{nextNode, nextProb});
                }
            }
        }

        return 0.0;
    }
}