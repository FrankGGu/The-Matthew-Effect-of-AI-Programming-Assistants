import java.util.*;

class Solution {
    public int minRectangles(int[][] points) {
        Set<String> uniquePoints = new HashSet<>();
        for (int[] point : points) {
            uniquePoints.add(point[0] + "," + point[1]);
        }

        List<int[]> list = new ArrayList<>(uniquePoints.size());
        for (String s : uniquePoints) {
            String[] coords = s.split(",");
            list.add(new int[]{Integer.parseInt(coords[0]), Integer.parseInt(coords[1])});
        }

        Collections.sort(list, (a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);

        int rectangles = 0;
        int n = list.size();
        boolean[] visited = new boolean[n];

        for (int i = 0; i < n; i++) {
            if (visited[i]) continue;
            rectangles++;
            int startX = list.get(i)[0];
            int startY = list.get(i)[1];
            visited[i] = true;

            for (int j = i + 1; j < n; j++) {
                if (!visited[j] && list.get(j)[0] >= startX && list.get(j)[1] >= startY) {
                    visited[j] = true;
                }
            }
        }

        return rectangles;
    }
}