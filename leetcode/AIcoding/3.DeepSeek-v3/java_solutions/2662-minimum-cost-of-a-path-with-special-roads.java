import java.util.*;

class Solution {
    public int minimumCost(int[] start, int[] target, int[][] specialRoads) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        Set<String> visited = new HashSet<>();
        pq.offer(new int[]{start[0], start[1], 0});
        int minCost = Integer.MAX_VALUE;

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int x = current[0], y = current[1], cost = current[2];
            String key = x + "," + y;
            if (visited.contains(key)) continue;
            visited.add(key);

            int directCost = cost + Math.abs(target[0] - x) + Math.abs(target[1] - y);
            minCost = Math.min(minCost, directCost);

            for (int[] road : specialRoads) {
                int x1 = road[0], y1 = road[1], x2 = road[2], y2 = road[3], roadCost = road[4];
                int newCost = cost + Math.abs(x1 - x) + Math.abs(y1 - y) + roadCost;
                if (newCost < minCost) {
                    pq.offer(new int[]{x2, y2, newCost});
                }
            }
        }

        return minCost;
    }
}