import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public double mincostToHireWorkers(int[] quality, int[] wage, int k) {
        int n = quality.length;
        double[][] workers = new double[n][2];
        for (int i = 0; i < n; i++) {
            workers[i][0] = (double) wage[i] / quality[i];
            workers[i][1] = quality[i];
        }
        Arrays.sort(workers, (a, b) -> Double.compare(a[0], b[0]));

        PriorityQueue<Double> pq = new PriorityQueue<>((a, b) -> Double.compare(b, a));
        double qualitySum = 0;
        double minCost = Double.MAX_VALUE;

        for (double[] worker : workers) {
            double ratio = worker[0];
            double q = worker[1];

            pq.offer(q);
            qualitySum += q;

            if (pq.size() > k) {
                qualitySum -= pq.poll();
            }

            if (pq.size() == k) {
                minCost = Math.min(minCost, ratio * qualitySum);
            }
        }

        return minCost;
    }
}