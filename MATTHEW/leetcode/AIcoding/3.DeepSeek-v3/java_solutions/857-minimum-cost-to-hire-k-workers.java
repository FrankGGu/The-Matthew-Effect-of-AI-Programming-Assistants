class Solution {
    public double mincostToHireWorkers(int[] quality, int[] wage, int k) {
        int n = quality.length;
        double[][] workers = new double[n][2];
        for (int i = 0; i < n; i++) {
            workers[i] = new double[]{(double) wage[i] / quality[i], (double) quality[i]};
        }
        Arrays.sort(workers, (a, b) -> Double.compare(a[0], b[0]));
        PriorityQueue<Double> maxHeap = new PriorityQueue<>((a, b) -> Double.compare(b, a));
        double sumQuality = 0;
        double res = Double.MAX_VALUE;
        for (double[] worker : workers) {
            sumQuality += worker[1];
            maxHeap.offer(worker[1]);
            if (maxHeap.size() > k) {
                sumQuality -= maxHeap.poll();
            }
            if (maxHeap.size() == k) {
                res = Math.min(res, sumQuality * worker[0]);
            }
        }
        return res;
    }
}