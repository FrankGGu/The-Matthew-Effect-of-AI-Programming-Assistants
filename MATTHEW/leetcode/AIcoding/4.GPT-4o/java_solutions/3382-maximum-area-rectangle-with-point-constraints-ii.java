import java.util.*;

class Solution {
    public int maxArea(int[][] points) {
        Set<Integer> xSet = new HashSet<>();
        Set<Integer> ySet = new HashSet<>();
        for (int[] point : points) {
            xSet.add(point[0]);
            ySet.add(point[1]);
        }

        int[] xCoords = xSet.stream().mapToInt(i -> i).sorted().toArray();
        int[] yCoords = ySet.stream().mapToInt(i -> i).sorted().toArray();

        int maxArea = 0;
        for (int i = 0; i < xCoords.length - 1; i++) {
            for (int j = 0; j < yCoords.length - 1; j++) {
                if (isRectangle(points, xCoords[i], xCoords[i + 1], yCoords[j], yCoords[j + 1])) {
                    maxArea = Math.max(maxArea, (xCoords[i + 1] - xCoords[i]) * (yCoords[j + 1] - yCoords[j]));
                }
            }
        }
        return maxArea;
    }

    private boolean isRectangle(int[][] points, int x1, int x2, int y1, int y2) {
        Set<String> pointSet = new HashSet<>();
        for (int[] point : points) {
            pointSet.add(point[0] + "," + point[1]);
        }
        return pointSet.contains(x1 + "," + y1) && pointSet.contains(x1 + "," + y2) && 
               pointSet.contains(x2 + "," + y1) && pointSet.contains(x2 + "," + y2);
    }
}