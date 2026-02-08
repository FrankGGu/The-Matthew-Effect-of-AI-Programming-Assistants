import java.util.PriorityQueue;

class Solution {
    public double maxAverageRatio(int[][] classes, int extraStudents) {
        PriorityQueue<double[]> pq = new PriorityQueue<>((a, b) -> Double.compare(b[0], a[0]));
        for (int[] c : classes) {
            double pass = c[0];
            double total = c[1];
            pq.offer(new double[]{ (pass + 1) / (total + 1) - pass / total, pass, total });
        }

        for (int i = 0; i < extraStudents; i++) {
            double[] curr = pq.poll();
            double diff = curr[0];
            double pass = curr[1];
            double total = curr[2];
            pass++;
            total++;
            pq.offer(new double[]{ (pass + 1) / (total + 1) - pass / total, pass, total });
        }

        double sum = 0;
        while (!pq.isEmpty()) {
            double[] curr = pq.poll();
            double pass = curr[1];
            double total = curr[2];
            sum += pass / total;
        }

        return sum / classes.length;
    }
}