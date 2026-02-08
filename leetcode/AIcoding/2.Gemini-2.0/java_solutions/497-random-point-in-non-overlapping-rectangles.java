import java.util.Random;

class Solution {

    private int[][] rects;
    private int[] prefixSum;
    private int totalArea;
    private Random random;

    public Solution(int[][] rects) {
        this.rects = rects;
        this.prefixSum = new int[rects.length];
        this.totalArea = 0;
        this.random = new Random();

        for (int i = 0; i < rects.length; i++) {
            int area = (rects[i][2] - rects[i][0] + 1) * (rects[i][3] - rects[i][1] + 1);
            totalArea += area;
            prefixSum[i] = totalArea;
        }
    }

    public int[] pick() {
        int rand = random.nextInt(totalArea);
        int rectIndex = binarySearch(rand);

        int x1 = rects[rectIndex][0];
        int y1 = rects[rectIndex][1];
        int x2 = rects[rectIndex][2];
        int y2 = rects[rectIndex][3];

        int x = x1 + random.nextInt(x2 - x1 + 1);
        int y = y1 + random.nextInt(y2 - y1 + 1);

        return new int[]{x, y};
    }

    private int binarySearch(int rand) {
        int low = 0;
        int high = prefixSum.length - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (prefixSum[mid] <= rand) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return low;
    }
}