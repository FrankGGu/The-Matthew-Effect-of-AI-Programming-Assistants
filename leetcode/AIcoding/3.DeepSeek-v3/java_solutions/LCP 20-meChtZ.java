import java.util.*;

class Solution {
    public int busRapidTransit(int target, int inc, int dec, int[] jump, int[] cost) {
        PriorityQueue<long[]> pq = new PriorityQueue<>((a, b) -> Long.compare(a[1], b[1]));
        Map<Long, Long> visited = new HashMap<>();
        pq.offer(new long[]{target, 0});
        long res = (long) target * inc;

        while (!pq.isEmpty()) {
            long[] curr = pq.poll();
            long pos = curr[0], time = curr[1];

            if (time >= res) continue;
            res = Math.min(res, time + pos * inc);

            if (pos == 0) break;

            if (visited.containsKey(pos) && visited.get(pos) <= time) continue;
            visited.put(pos, time);

            for (int i = 0; i < jump.length; i++) {
                int j = jump[i];
                long nextPos = pos / j;
                long remainder = pos % j;
                if (remainder == 0) {
                    pq.offer(new long[]{nextPos, time + cost[i]});
                } else {
                    pq.offer(new long[]{nextPos, time + cost[i] + remainder * inc});
                    pq.offer(new long[]{nextPos + 1, time + cost[i] + (j - remainder) * dec});
                }
            }
        }

        return (int) (res % 1_000_000_007);
    }
}