public class Solution {

import java.util.*;

public class Solution {
    public double mincostToHireKWorkers(int[] quality, int[] wage, int K) {
        int n = quality.length;
        int[][] workers = new int[n][2];
        for (int i = 0; i < n; ++i) {
            workers[i][0] = quality[i];
            workers[i][1] = wage[i];
        }

        Arrays.sort(workers, (a, b) -> a[0] - b[0]);

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        int totalQuality = 0;
        double minCost = Double.MAX_VALUE;

        for (int i = 0; i < n; ++i) {
            int q = workers[i][0];
            int w = workers[i][1];
            double ratio = (double) w / q;

            maxHeap.add(q);
            totalQuality += q;

            if (maxHeap.size() > K) {
                totalQuality -= maxHeap.poll();
            }

            if (maxHeap.size() == K) {
                minCost = Math.min(minCost, totalQuality * ratio);
            }
        }

        return minCost;
    }
}
}