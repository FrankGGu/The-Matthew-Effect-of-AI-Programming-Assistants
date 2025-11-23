import java.util.*;

class Solution {
    public int minimumCost(int[] start, int[] target, int[][] specialRoads) {
        int sx = start[0], sy = start[1], tx = target[0], ty = target[1];
        Map<String, Integer> dist = new HashMap<>();
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));

        dist.put(sx + "," + sy, 0);
        pq.offer(new int[]{0, sx, sy});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int cost = curr[0], x = curr[1], y = curr[2];
            String key = x + "," + y;

            if (cost > dist.getOrDefault(key, Integer.MAX_VALUE)) {
                continue;
            }

            int directCost = Math.abs(tx - x) + Math.abs(ty - y);
            if (dist.getOrDefault(tx + "," + ty, Integer.MAX_VALUE) > cost + directCost) {
                dist.put(tx + "," + ty, cost + directCost);
            }

            for (int[] road : specialRoads) {
                int u = road[0], v = road[1], i = road[2], j = road[3], c = road[4];
                int newCost = cost + Math.abs(u - x) + Math.abs(v - y) + c;
                String newKey = i + "," + j;
                if (dist.getOrDefault(newKey, Integer.MAX_VALUE) > newCost) {
                    dist.put(newKey, newCost);
                    pq.offer(new int[]{newCost, i, j});
                }
            }
        }

        return dist.getOrDefault(tx + "," + ty, Integer.MAX_VALUE);
    }
}