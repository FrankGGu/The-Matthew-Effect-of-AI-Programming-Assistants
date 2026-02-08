public class Solution {

import java.util.*;

public class Solution {
    public int minRefuelStops(int target, int startFuel, int[][] stations) {
        PriorityQueue<Integer> pq = new PriorityQueue<>(Collections.reverseOrder());
        int count = 0;
        int prev = 0;
        int fuel = startFuel;

        for (int[] station : stations) {
            int distance = station[0];
            int oil = station[1];

            fuel -= distance - prev;

            while (fuel < 0 && !pq.isEmpty()) {
                fuel += pq.poll();
                count++;
            }

            if (fuel < 0) return -1;

            pq.add(oil);
            prev = distance;
        }

        fuel -= target - prev;

        while (fuel < 0 && !pq.isEmpty()) {
            fuel += pq.poll();
            count++;
        }

        return fuel < 0 ? -1 : count;
    }
}
}