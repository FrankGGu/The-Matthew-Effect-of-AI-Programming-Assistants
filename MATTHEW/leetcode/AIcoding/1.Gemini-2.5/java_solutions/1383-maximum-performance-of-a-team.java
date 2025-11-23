import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public long maxPerformance(int n, int[] speeds, int[] efficiencies, int k) {
        int[][] engineers = new int[n][2];
        for (int i = 0; i < n; i++) {
            engineers[i][0] = efficiencies[i];
            engineers[i][1] = speeds[i];
        }

        Arrays.sort(engineers, (a, b) -> b[0] - a[0]);

        PriorityQueue<Integer> minHeap = new PriorityQueue<>();

        long currentSumOfSpeeds = 0;
        long maxPerformance = 0;

        for (int[] engineer : engineers) {
            int currentEfficiency = engineer[0];
            int currentSpeed = engineer[1];

            currentSumOfSpeeds += currentSpeed;
            minHeap.add(currentSpeed);

            if (minHeap.size() > k) {
                currentSumOfSpeeds -= minHeap.poll();
            }

            maxPerformance = Math.max(maxPerformance, currentSumOfSpeeds * currentEfficiency);
        }

        return maxPerformance;
    }
}