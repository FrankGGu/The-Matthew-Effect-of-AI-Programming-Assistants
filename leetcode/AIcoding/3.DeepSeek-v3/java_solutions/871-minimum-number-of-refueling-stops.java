import java.util.*;

class Solution {
    public int minRefuelStops(int target, int startFuel, int[][] stations) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        int res = 0;
        int prev = 0;
        int tank = startFuel;
        for (int[] station : stations) {
            int location = station[0];
            int fuel = station[1];
            tank -= (location - prev);
            while (!maxHeap.isEmpty() && tank < 0) {
                tank += maxHeap.poll();
                res++;
            }
            if (tank < 0) return -1;
            maxHeap.offer(fuel);
            prev = location;
        }
        tank -= (target - prev);
        while (!maxHeap.isEmpty() && tank < 0) {
            tank += maxHeap.poll();
            res++;
        }
        if (tank < 0) return -1;
        return res;
    }
}