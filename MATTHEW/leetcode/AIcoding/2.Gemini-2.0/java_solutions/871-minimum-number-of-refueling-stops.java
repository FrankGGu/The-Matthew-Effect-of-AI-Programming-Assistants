import java.util.PriorityQueue;

class Solution {
    public int minRefuelStops(int target, int startFuel, int[][] stations) {
        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        int i = 0, res = 0;
        int currFuel = startFuel;
        while (currFuel < target) {
            while (i < stations.length && stations[i][0] <= currFuel) {
                pq.offer(stations[i++][1]);
            }
            if (pq.isEmpty()) return -1;
            currFuel += pq.poll();
            res++;
        }
        return res;
    }
}