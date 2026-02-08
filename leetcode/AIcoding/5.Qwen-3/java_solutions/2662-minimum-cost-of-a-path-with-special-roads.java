public class Solution {

import java.util.*;

public class Solution {
    public int minimumCostToReachCorner(int x1, int y1, int x2, int y2, int[][] specialRoads) {
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[2]));
        Set<String> visited = new HashSet<>();
        Map<String, Integer> costMap = new HashMap<>();

        pq.offer(new int[]{x1, y1, 0});
        costMap.put(x1 + "," + y1, 0);

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int x = current[0];
            int y = current[1];
            int cost = current[2];

            if (x == x2 && y == y2) {
                return cost;
            }

            String key = x + "," + y;
            if (visited.contains(key)) {
                continue;
            }
            visited.add(key);

            for (int[] dir : directions) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && ny >= 0 && nx <= 1000 && ny <= 1000) {
                    String nextKey = nx + "," + ny;
                    int newCost = cost + 1;
                    if (!costMap.containsKey(nextKey) || newCost < costMap.get(nextKey)) {
                        costMap.put(nextKey, newCost);
                        pq.offer(new int[]{nx, ny, newCost});
                    }
                }
            }

            for (int[] road : specialRoads) {
                int sx = road[0];
                int sy = road[1];
                int ex = road[2];
                int ey = road[3];
                int costToRoad = cost + Math.abs(x - sx) + Math.abs(y - sy);
                String roadStartKey = sx + "," + sy;
                if (!costMap.containsKey(roadStartKey) || costToRoad < costMap.get(roadStartKey)) {
                    costMap.put(roadStartKey, costToRoad);
                    pq.offer(new int[]{sx, sy, costToRoad});
                }

                int costFromRoad = costToRoad + Math.abs(ex - sx) + Math.abs(ey - sy);
                String roadEndKey = ex + "," + ey;
                if (!costMap.containsKey(roadEndKey) || costFromRoad < costMap.get(roadEndKey)) {
                    costMap.put(roadEndKey, costFromRoad);
                    pq.offer(new int[]{ex, ey, costFromRoad});
                }
            }
        }

        return -1;
    }
}
}