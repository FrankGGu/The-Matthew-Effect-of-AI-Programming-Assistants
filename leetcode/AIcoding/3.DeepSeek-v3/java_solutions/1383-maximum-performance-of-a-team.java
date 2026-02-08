import java.util.*;

class Solution {
    public int maxPerformance(int n, int[] speed, int[] efficiency, int k) {
        int[][] engineers = new int[n][2];
        for (int i = 0; i < n; i++) {
            engineers[i] = new int[]{efficiency[i], speed[i]};
        }
        Arrays.sort(engineers, (a, b) -> b[0] - a[0]);

        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        long totalSpeed = 0;
        long maxPerformance = 0;

        for (int[] engineer : engineers) {
            int currentEfficiency = engineer[0];
            int currentSpeed = engineer[1];

            if (minHeap.size() == k) {
                totalSpeed -= minHeap.poll();
            }
            minHeap.add(currentSpeed);
            totalSpeed += currentSpeed;

            long currentPerformance = totalSpeed * currentEfficiency;
            if (currentPerformance > maxPerformance) {
                maxPerformance = currentPerformance;
            }
        }

        return (int) (maxPerformance % (1_000_000_007));
    }
}