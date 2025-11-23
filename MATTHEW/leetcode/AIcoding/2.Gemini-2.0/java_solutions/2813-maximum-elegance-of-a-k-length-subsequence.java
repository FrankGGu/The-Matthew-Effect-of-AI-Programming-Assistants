import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public long findMaximumElegance(int[][] items, int k) {
        Arrays.sort(items, (a, b) -> b[0] - a[0]);

        long ans = 0;
        long profit = 0;
        int count = 0;
        PriorityQueue<Integer> pq = new PriorityQueue<>();

        for (int i = 0; i < items.length; i++) {
            if (count < k) {
                profit += items[i][0];
                if (items[i][1] == 1) {
                    count++;
                    pq.offer(items[i][0]);
                }
            } else {
                if (items[i][1] == 1 && !pq.isEmpty() && items[i][0] > pq.peek()) {
                    profit -= pq.poll();
                    profit += items[i][0];
                    pq.offer(items[i][0]);
                }
            }
        }

        ans = profit + (long) count * count;

        return ans;
    }
}