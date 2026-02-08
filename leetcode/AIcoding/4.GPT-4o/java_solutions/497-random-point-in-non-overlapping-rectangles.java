import java.util.Random;

class Solution {
    private int[][] rects;
    private int[] prefixSums;
    private int totalArea;
    private Random random;

    public Solution(int[][] rects) {
        this.rects = rects;
        this.prefixSums = new int[rects.length];
        this.totalArea = 0;
        this.random = new Random();

        for (int i = 0; i < rects.length; i++) {
            int x1 = rects[i][0], y1 = rects[i][1], x2 = rects[i][2], y2 = rects[i][3];
            int area = (x2 - x1) * (y2 - y1);
            totalArea += area;
            prefixSums[i] = totalArea;
        }
    }

    public int[] pick() {
        int target = random.nextInt(totalArea);
        int rectIndex = binarySearch(target);
        int[] rect = rects[rectIndex];

        int x1 = rect[0], y1 = rect[1], x2 = rect[2], y2 = rect[3];
        int x = x1 + random.nextInt(x2 - x1);
        int y = y1 + random.nextInt(y2 - y1);

        return new int[]{x, y};
    }

    private int binarySearch(int target) {
        int left = 0, right = prefixSums.length - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (prefixSums[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}