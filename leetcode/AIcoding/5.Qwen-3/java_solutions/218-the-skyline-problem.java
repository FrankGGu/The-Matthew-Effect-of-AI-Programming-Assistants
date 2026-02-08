public class Solution {

import java.util.*;

public class Solution {
    public List<int[]> getSkyline(int[][] buildings) {
        List<int[]> result = new ArrayList<>();
        if (buildings == null || buildings.length == 0) return result;

        List<int[]> points = new ArrayList<>();
        for (int[] building : buildings) {
            points.add(new int[]{building[0], -building[2]});
            points.add(new int[]{building[1], building[2]});
        }

        Collections.sort(points, (a, b) -> {
            if (a[0] != b[0]) return a[0] - b[0];
            return a[1] - b[1];
        });

        PriorityQueue<Integer> pq = new PriorityQueue<>();
        pq.offer(0);
        int prevHeight = 0;

        for (int[] point : points) {
            int x = point[0];
            int height = point[1];

            if (height < 0) {
                pq.offer(-height);
            } else {
                pq.remove(height);
            }

            int currentHeight = pq.peek();
            if (currentHeight != prevHeight) {
                result.add(new int[]{x, currentHeight});
                prevHeight = currentHeight;
            }
        }

        return result;
    }
}
}