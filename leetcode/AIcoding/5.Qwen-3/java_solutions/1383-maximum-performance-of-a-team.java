public class Solution {

import java.util.*;

public class Solution {
    public int maxPerformance(int n, int[] speed, int[] efficiency, int k) {
        int[][] engineers = new int[n][2];
        for (int i = 0; i < n; i++) {
            engineers[i][0] = speed[i];
            engineers[i][1] = efficiency[i];
        }

        Arrays.sort(engineers, (a, b) -> b[1] - a[1]);

        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        int totalSpeed = 0;
        int maxPerformance = 0;

        for (int[] engineer : engineers) {
            int speedVal = engineer[0];
            int effVal = engineer[1];

            if (minHeap.size() == k) {
                int minSpeed = minHeap.poll();
                totalSpeed -= minSpeed;
            }

            minHeap.offer(speedVal);
            totalSpeed += speedVal;
            maxPerformance = Math.max(maxPerformance, totalSpeed * effVal);
        }

        return maxPerformance;
    }
}
}