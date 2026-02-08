import java.util.*;

public class Solution {
    public int maxArea(int[][] points) {
        Set<Integer> xSet = new HashSet<>();
        Set<Integer> ySet = new HashSet<>();

        for (int[] point : points) {
            xSet.add(point[0]);
            ySet.add(point[1]);
        }

        List<Integer> xList = new ArrayList<>(xSet);
        List<Integer> yList = new ArrayList<>(ySet);

        Collections.sort(xList);
        Collections.sort(yList);

        int maxArea = 0;

        for (int i = 1; i < xList.size(); i++) {
            for (int j = 1; j < yList.size(); j++) {
                if (canFormRectangle(xList.get(i - 1), yList.get(j - 1), xList.get(i), yList.get(j), points)) {
                    int area = (xList.get(i) - xList.get(i - 1)) * (yList.get(j) - yList.get(j - 1));
                    maxArea = Math.max(maxArea, area);
                }
            }
        }

        return maxArea;
    }

    private boolean canFormRectangle(int x1, int y1, int x2, int y2, int[][] points) {
        Set<String> pointSet = new HashSet<>();
        for (int[] point : points) {
            pointSet.add(point[0] + "," + point[1]);
        }
        return pointSet.contains(x1 + "," + y1) && pointSet.contains(x1 + "," + y2) 
            && pointSet.contains(x2 + "," + y1) && pointSet.contains(x2 + "," + y2);
    }
}