public class Solution {

import java.util.*;

public class Solution {
    public int kthSmallestChair(int[][] times, int k) {
        int n = times.length;
        int[][] events = new int[n][3];

        for (int i = 0; i < n; i++) {
            events[i][0] = times[i][0]; // arrival time
            events[i][1] = times[i][1]; // departure time
            events[i][2] = i; // person index
        }

        Arrays.sort(events, (a, b) -> a[0] != b[0] ? a[0] - b[0] : a[1] - b[1]);

        PriorityQueue<int[]> departures = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        TreeSet<Integer> available = new TreeSet<>();

        for (int i = 0; i < n; i++) {
            int[] event = events[i];
            int arrival = event[0];
            int departure = event[1];
            int person = event[2];

            while (!departures.isEmpty() && departures.peek()[1] <= arrival) {
                int[] d = departures.poll();
                available.add(d[2]);
            }

            if (available.isEmpty()) {
                available.add(n);
            }

            int chair = available.pollFirst();
            if (k == 1) {
                return chair;
            }
            k--;
            departures.add(new int[]{departure, person, chair});
        }

        return -1;
    }
}
}