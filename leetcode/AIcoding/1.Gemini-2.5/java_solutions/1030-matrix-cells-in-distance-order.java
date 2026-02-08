import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[][] allCellsDistOrder(int R, int C, int r0, int c0) {
        int maxDist = Math.max(r0, R - 1 - r0) + Math.max(c0, C - 1 - c0);
        List<List<int[]>> buckets = new ArrayList<>();
        for (int i = 0; i <= maxDist; i++) {
            buckets.add(new ArrayList<>());
        }

        for (int r = 0; r < R; r++) {
            for (int c = 0; c < C; c++) {
                int dist = Math.abs(r - r0) + Math.abs(c - c0);
                buckets.get(dist).add(new int[]{r, c});
            }
        }

        int[][] result = new int[R * C][2];
        int index = 0;
        for (int d = 0; d <= maxDist; d++) {
            for (int[] cell : buckets.get(d)) {
                result[index++] = cell;
            }
        }

        return result;
    }
}