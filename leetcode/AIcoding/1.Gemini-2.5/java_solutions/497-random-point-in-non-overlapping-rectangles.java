import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Collections;

class Solution {

    private int[][] rects;
    private List<Integer> prefixSums;
    private Random random;
    private int totalArea;

    public Solution(int[][] rects) {
        this.rects = rects;
        this.prefixSums = new ArrayList<>();
        this.random = new Random();
        this.totalArea = 0;

        for (int[] rect : rects) {
            int x1 = rect[0];
            int y1 = rect[1];
            int x2 = rect[2];
            int y2 = rect[3];

            // Area is (width * height)
            // For integer points, width is (x2 - x1 + 1) and height is (y2 - y1 + 1)
            int width = x2 - x1 + 1;
            int height = y2 - y1 + 1;
            int area = width * height;

            totalArea += area;
            prefixSums.add(totalArea);
        }
    }

    public int[] pick() {
        // Generate a random number between 1 and totalArea (inclusive)
        int targetArea = random.nextInt(totalArea) + 1;

        // Find the rectangle using binary search on prefix sums
        int rectIndex = Collections.binarySearch(prefixSums, targetArea);
        if (rectIndex < 0) {
            // If not found, Collections.binarySearch returns -(insertion_point) - 1
            // The insertion_point is the index of the first element greater than the key.
            // So, -rectIndex - 1 gives the correct index.
            rectIndex = -rectIndex - 1;
        }

        // Get the chosen rectangle
        int[] chosenRect = rects[rectIndex];
        int x1 = chosenRect[0];
        int y1 = chosenRect[1];
        int x2 = chosenRect[2];
        int y2 = chosenRect[3];

        // Pick a random integer point within the chosen rectangle
        int randX = x1 + random.nextInt(x2 - x1 + 1);
        int randY = y1 + random.nextInt(y2 - y1 + 1);

        return new int[]{randX, randY};
    }
}