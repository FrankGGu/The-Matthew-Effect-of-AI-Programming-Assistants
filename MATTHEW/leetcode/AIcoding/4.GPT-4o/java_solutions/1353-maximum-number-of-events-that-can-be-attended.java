import java.util.Arrays;
import java.util.PriorityQueue;

public class Solution {
    public int maxEvents(int[][] events) {
        Arrays.sort(events, (a, b) -> Integer.compare(a[0], b[0]));
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        int count = 0, idx = 0, n = events.length, day = 1;

        while (idx < n || !pq.isEmpty()) {
            while (idx < n && events[idx][0] == day) {
                pq.offer(events[idx][1]);
                idx++;
            }
            if (!pq.isEmpty()) {
                pq.poll();
                count++;
            }
            day++;
            while (!pq.isEmpty() && pq.peek() < day) {
                pq.poll();
            }
        }

        return count;
    }
}