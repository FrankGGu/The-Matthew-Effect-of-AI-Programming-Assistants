class Solution {
    public double maxAverageRatio(int[][] classes, int extraStudents) {
        PriorityQueue<double[]> pq = new PriorityQueue<>((a, b) -> {
            double aDiff = (a[0] + 1) / (a[1] + 1 - a[0] / a[1];
            double bDiff = (b[0] + 1) / (b[1] + 1 - b[0] / b[1];
            return Double.compare(bDiff, aDiff);
        });

        for (int[] c : classes) {
            pq.offer(new double[]{c[0], c[1]});
        }

        for (int i = 0; i < extraStudents; i++) {
            double[] curr = pq.poll();
            curr[0] += 1;
            curr[1] += 1;
            pq.offer(curr);
        }

        double sum = 0;
        while (!pq.isEmpty()) {
            double[] curr = pq.poll();
            sum += curr[0] / curr[1];
        }

        return sum / classes.length;
    }
}