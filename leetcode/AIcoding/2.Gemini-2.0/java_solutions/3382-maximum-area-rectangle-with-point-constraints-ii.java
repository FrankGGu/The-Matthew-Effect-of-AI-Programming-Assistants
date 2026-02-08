import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int solve(int[][] points) {
        int n = points.length;
        List<Integer> xCoords = new ArrayList<>();
        for (int[] point : points) {
            xCoords.add(point[0]);
        }
        Collections.sort(xCoords);
        List<Integer> uniqueXCoords = new ArrayList<>();
        for (int x : xCoords) {
            if (uniqueXCoords.isEmpty() || uniqueXCoords.get(uniqueXCoords.size() - 1) != x) {
                uniqueXCoords.add(x);
            }
        }

        int maxArea = 0;
        for (int i = 0; i < uniqueXCoords.size(); i++) {
            for (int j = i + 1; j < uniqueXCoords.size(); j++) {
                int left = uniqueXCoords.get(i);
                int right = uniqueXCoords.get(j);
                int minY = Integer.MAX_VALUE;
                int maxY = Integer.MIN_VALUE;
                for (int[] point : points) {
                    if (point[0] >= left && point[0] <= right) {
                        minY = Math.min(minY, point[1]);
                        maxY = Math.max(maxY, point[1]);
                    }
                }
                if (minY != Integer.MAX_VALUE && maxY != Integer.MIN_VALUE) {
                    int currentMinY = Integer.MAX_VALUE;
                    int currentMaxY = Integer.MIN_VALUE;
                    for (int[] point : points) {
                        if (point[0] >= left && point[0] <= right && point[1] >= minY && point[1] <= maxY) {
                            currentMinY = Math.min(currentMinY, point[1]);
                            currentMaxY = Math.max(currentMaxY, point[1]);
                        }
                    }
                    if (currentMinY != Integer.MAX_VALUE && currentMaxY != Integer.MIN_VALUE) {
                        maxArea = Math.max(maxArea, (right - left) * (currentMaxY - currentMinY));
                    }
                }
            }
        }

        return maxArea;
    }
}