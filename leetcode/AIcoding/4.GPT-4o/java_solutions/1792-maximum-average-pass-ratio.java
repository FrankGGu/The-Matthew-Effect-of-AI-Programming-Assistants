import java.util.PriorityQueue;

public class Solution {
    public double maxAverageRatio(int[][] classes, int extraStudents) {
        PriorityQueue<double[]> pq = new PriorityQueue<>((a, b) -> Double.compare(b[0], a[0]));
        double total = 0;

        for (int[] c : classes) {
            double passRatio = (double)(c[0] + 1) / (c[1] + 1) - (double)c[0] / c[1];
            pq.offer(new double[]{passRatio, c[0], c[1]});
        }

        for (int i = 0; i < extraStudents; i++) {
            double[] curr = pq.poll();
            curr[0] = (curr[1] + 1) / (curr[2] + 1) - curr[1] / curr[2];
            curr[1]++;
            curr[2]++;
            pq.offer(curr);
        }

        while (!pq.isEmpty()) {
            double[] curr = pq.poll();
            total += curr[1] / curr[2];
        }

        return total / classes.length;
    }
}