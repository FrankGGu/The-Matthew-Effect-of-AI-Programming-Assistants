import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int maxPerformance(int n, int[] speed, int[] efficiency, int k) {
        int[][] engineers = new int[n][2];
        for (int i = 0; i < n; i++) {
            engineers[i][0] = efficiency[i];
            engineers[i][1] = speed[i];
        }

        Arrays.sort(engineers, (a, b) -> b[0] - a[0]);

        PriorityQueue<Integer> pq = new PriorityQueue<>();
        long sum = 0;
        long maxPerformance = 0;

        for (int i = 0; i < n; i++) {
            int currEfficiency = engineers[i][0];
            int currSpeed = engineers[i][1];

            pq.offer(currSpeed);
            sum += currSpeed;

            if (pq.size() > k) {
                sum -= pq.poll();
            }

            maxPerformance = Math.max(maxPerformance, sum * currEfficiency);
        }

        return (int) (maxPerformance % 1000000007);
    }
}