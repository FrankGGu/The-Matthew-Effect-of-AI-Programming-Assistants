import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int maxEvents(int[][] events) {
        Arrays.sort(events, (a, b) -> a[0] - b[0]);
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        int i = 0, count = 0, day = 0;
        while (i < events.length || !pq.isEmpty()) {
            if (pq.isEmpty()) {
                day = events[i][0];
            }
            while (i < events.length && events[i][0] <= day) {
                pq.offer(events[i][1]);
                i++;
            }
            pq.poll();
            count++;
            day++;
            while (!pq.isEmpty() && pq.peek() < day) {
                pq.poll();
            }
        }
        return count;
    }
}