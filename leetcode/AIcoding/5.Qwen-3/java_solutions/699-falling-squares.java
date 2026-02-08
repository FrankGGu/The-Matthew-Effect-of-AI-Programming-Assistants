public class Solution {

import java.util.*;

public class FallingSquares {
    public List<int[]> result = new ArrayList<>();
    public List<int[]> intervals = new ArrayList<>();

    public List<int[]> getSkyline(int[][] buildings) {
        int n = buildings.length;
        for (int i = 0; i < n; i++) {
            int left = buildings[i][0];
            int right = buildings[i][1];
            int height = buildings[i][2];
            int currentHeight = height;
            for (int j = 0; j < intervals.size(); j++) {
                int[] interval = intervals.get(j);
                if (interval[0] < right && interval[1] > left) {
                    currentHeight = Math.max(currentHeight, interval[2]);
                }
            }
            intervals.add(new int[]{left, right, currentHeight});
            if (currentHeight > 0) {
                result.add(new int[]{left, currentHeight});
                result.add(new int[]{right, currentHeight});
            }
        }

        Collections.sort(result, (a, b) -> {
            if (a[0] != b[0]) return a[0] - b[0];
            return b[1] - a[1];
        });

        List<int[]> finalResult = new ArrayList<>();
        int prevHeight = 0;
        for (int[] point : result) {
            if (point[1] != prevHeight) {
                finalResult.add(point);
                prevHeight = point[1];
            }
        }

        return finalResult;
    }
}
}