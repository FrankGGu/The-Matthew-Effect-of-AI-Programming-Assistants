import java.util.*;

class Solution {
    public int countRightTriangles(int[][] coordinates) {
        Map<Integer, Integer> xMap = new HashMap<>();
        Map<Integer, Integer> yMap = new HashMap<>();

        for (int[] coord : coordinates) {
            int x = coord[0];
            int y = coord[1];
            xMap.put(x, xMap.getOrDefault(x, 0) + 1);
            yMap.put(y, yMap.getOrDefault(y, 0) + 1);
        }

        int count = 0;
        for (int[] coord : coordinates) {
            int x = coord[0];
            int y = coord[1];
            count += (xMap.get(x) - 1) * (yMap.get(y) - 1);
        }

        return count;
    }
}