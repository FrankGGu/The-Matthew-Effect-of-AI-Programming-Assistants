import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int maxPerformance(int n, int[] speed, int[] efficiency, int k) {
        int mod = 1000000007;
        int[][] engineers = new int[n][2];
        for (int i = 0; i < n; i++) {
            engineers[i][0] = efficiency[i];
            engineers[i][1] = speed[i];
        }
        Arrays.sort(engineers, (a, b) -> b[0] - a[0]);

        long totalSpeed = 0;
        long maxPerformance = 0;
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();

        for (int[] engineer : engineers) {
            totalSpeed += engineer[1];
            minHeap.offer(engineer[1]);
            if (minHeap.size() > k) {
                totalSpeed -= minHeap.poll();
            }
            maxPerformance = Math.max(maxPerformance, totalSpeed * engineer[0]);
        }

        return (int) (maxPerformance % mod);
    }
}