public class Solution {

import java.util.*;

public class Solution {
    private int[] prefixSums;
    private List<int[]> rectangles;
    private Random random;

    public Solution(int[][] rects) {
        rectangles = new ArrayList<>();
        for (int[] rect : rects) {
            rectangles.add(rect);
        }
        prefixSums = new int[rectangles.size()];
        prefixSums[0] = (rectangles.get(0)[2] - rectangles.get(0)[0] + 1) * (rectangles.get(0)[3] - rectangles.get(0)[1] + 1);
        for (int i = 1; i < rectangles.size(); i++) {
            int area = (rectangles.get(i)[2] - rectangles.get(i)[0] + 1) * (rectangles.get(i)[3] - rectangles.get(i)[1] + 1);
            prefixSums[i] = prefixSums[i - 1] + area;
        }
        random = new Random();
    }

    public int[] pick() {
        int total = prefixSums[prefixSums.length - 1];
        int rand = random.nextInt(total);
        int left = 0;
        int right = prefixSums.length - 1;
        while (left < right) {
            int mid = (left + right) / 2;
            if (rand >= prefixSums[mid]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        int[] rect = rectangles.get(left);
        int x = rect[0] + random.nextInt(rect[2] - rect[0] + 1);
        int y = rect[1] + random.nextInt(rect[3] - rect[1] + 1);
        return new int[]{x, y};
    }
}
}