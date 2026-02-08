class Solution {
    public double maxProbability(int n, int[][] edges, double[] succProb, int start, int end) {
        List<List<Pair<Integer, Double>>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int i = 0; i < edges.length; i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            double prob = succProb[i];
            graph.get(u).add(new Pair<>(v, prob));
            graph.get(v).add(new Pair<>(u, prob));
        }

        double[] maxProb = new double[n];
        maxProb[start] = 1.0;

        PriorityQueue<Pair<Integer, Double>> pq = new PriorityQueue<>((a, b) -> Double.compare(b.getValue(), a.getValue()));
        pq.offer(new Pair<>(start, 1.0));

        while (!pq.isEmpty()) {
            Pair<Integer, Double> current = pq.poll();
            int currentNode = current.getKey();
            double currentProb = current.getValue();

            if (currentNode == end) {
                return currentProb;
            }

            if (currentProb < maxProb[currentNode]) {
                continue;
            }

            for (Pair<Integer, Double> neighbor : graph.get(currentNode)) {
                int nextNode = neighbor.getKey();
                double nextProb = neighbor.getValue();
                double newProb = currentProb * nextProb;

                if (newProb > maxProb[nextNode]) {
                    maxProb[nextNode] = newProb;
                    pq.offer(new Pair<>(nextNode, newProb));
                }
            }
        }

        return 0.0;
    }
}