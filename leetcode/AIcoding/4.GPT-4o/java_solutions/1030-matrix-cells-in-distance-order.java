import java.util.*;

public class Solution {
    public int[][] allCellsDistOrder(int R, int C, int r0, int c0) {
        int[][] result = new int[R * C][2];
        int index = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
            int distA = Math.abs(a[0] - r0) + Math.abs(a[1] - c0);
            int distB = Math.abs(b[0] - r0) + Math.abs(b[1] - c0);
            return Integer.compare(distA, distB);
        });

        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                pq.offer(new int[]{i, j});
            }
        }

        while (!pq.isEmpty()) {
            result[index++] = pq.poll();
        }

        return result;
    }
}