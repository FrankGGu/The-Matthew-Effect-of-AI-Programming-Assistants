import java.util.PriorityQueue;

public class Solution {
    public int minRefuelStops(int target, int startFuel, int[][] stations) {
        int n = stations.length;
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        int fuel = startFuel, count = 0, index = 0;

        for (int i = 0; i <= n; i++) {
            int position = (i == n) ? target : stations[i][0];
            while (fuel < position) {
                if (maxHeap.isEmpty()) return -1;
                fuel += maxHeap.poll();
                count++;
            }
            if (i < n) maxHeap.offer(stations[i][1]);
        }
        return count;
    }
}