import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.PriorityQueue;

class Solution {

    private static class Worker {
        double ratio;
        int quality;
        int wage;

        public Worker(int wage, int quality) {
            this.wage = wage;
            this.quality = quality;
            this.ratio = (double) wage / quality;
        }
    }

    public double minCostToHireWorkers(int[] quality, int[] wage, int k) {
        int n = quality.length;
        List<Worker> workers = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            workers.add(new Worker(wage[i], quality[i]));
        }

        Collections.sort(workers, (a, b) -> Double.compare(a.ratio, b.ratio));

        double minCost = Double.MAX_VALUE;
        int currentQualitySum = 0;
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());

        for (Worker worker : workers) {
            maxHeap.add(worker.quality);
            currentQualitySum += worker.quality;

            if (maxHeap.size() > k) {
                currentQualitySum -= maxHeap.poll();
            }

            if (maxHeap.size() == k) {
                minCost = Math.min(minCost, worker.ratio * currentQualitySum);
            }
        }

        return minCost;
    }
}