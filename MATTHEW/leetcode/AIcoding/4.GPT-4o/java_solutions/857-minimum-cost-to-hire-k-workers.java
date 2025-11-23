import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public double minCostToHireWorkers(int[] quality, int[] wage, int K) {
        int n = quality.length;
        Worker[] workers = new Worker[n];

        for (int i = 0; i < n; i++) {
            workers[i] = new Worker(quality[i], wage[i]);
        }

        Arrays.sort(workers, (a, b) -> Double.compare(a.ratio, b.ratio));

        double cost = Double.MAX_VALUE;
        double qualitySum = 0;
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);

        for (Worker worker : workers) {
            qualitySum += worker.quality;
            maxHeap.offer(worker.quality);

            if (maxHeap.size() > K) {
                qualitySum -= maxHeap.poll();
            }

            if (maxHeap.size() == K) {
                cost = Math.min(cost, qualitySum * worker.ratio);
            }
        }

        return cost;
    }

    class Worker {
        int quality;
        int wage;
        double ratio;

        Worker(int quality, int wage) {
            this.quality = quality;
            this.wage = wage;
            this.ratio = (double) wage / quality;
        }
    }
}