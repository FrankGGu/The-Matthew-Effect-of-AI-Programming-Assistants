import java.util.*;

class Solution {
    public int findCrossingTime(int n, int k, int[][] time) {
        int ans = 0;
        int left = 0, right = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>(k, (a, b) -> a[0] - b[0]);
        for (int i = 0; i < k; i++) {
            pq.offer(new int[]{time[i][0], i});
        }
        int[] nextFinish = new int[n];
        Arrays.fill(nextFinish, Integer.MAX_VALUE);
        for (int i = 0; i < n; i++) {
            if (right < k) {
                ans = Math.max(ans, pq.peek()[0]);
                while (right < k && pq.peek()[0] <= ans) {
                    int[] worker = pq.poll();
                    nextFinish[i] = Math.min(nextFinish[i], ans + time[worker[1]][1]);
                    right++;
                }
            }
            ans = Math.min(ans + time[i % k][0], nextFinish[i]);
            if (i >= n - k) {
                nextFinish[i] = Integer.MAX_VALUE;
            }
        }
        return ans;
    }
}