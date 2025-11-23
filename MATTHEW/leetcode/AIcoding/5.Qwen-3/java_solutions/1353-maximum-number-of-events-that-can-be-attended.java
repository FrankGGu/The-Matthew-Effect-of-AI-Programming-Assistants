public class Solution {

import java.util.*;

public class Solution {
    public int maxEvents(int[][] events) {
        Arrays.sort(events, (a, b) -> a[0] - b[0]);
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        int count = 0;
        int i = 0;
        int n = events.length;
        while (i < n || !pq.isEmpty()) {
            if (pq.isEmpty()) {
                pq.add(events[i][1]);
                i++;
            } else {
                if (i < n && events[i][0] <= pq.peek()) {
                    pq.add(events[i][1]);
                    i++;
                } else {
                    pq.poll();
                    count++;
                }
            }
        }
        return count;
    }
}
}