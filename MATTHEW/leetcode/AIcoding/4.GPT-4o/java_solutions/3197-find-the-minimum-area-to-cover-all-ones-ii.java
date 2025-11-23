import java.util.*;

public class Solution {
    public int minArea(char[][] image, int x, int y) {
        int m = image.length, n = image[0].length;
        int left = binarySearchColumn(image, 0, y, 0, m, true);
        int right = binarySearchColumn(image, y + 1, n, 0, m, false);
        int top = binarySearchRow(image, 0, x, left, right, true);
        int bottom = binarySearchRow(image, x + 1, m, left, right, false);
        return (right - left) * (bottom - top);
    }

    private int binarySearchColumn(char[][] image, int low, int high, int top, int bottom, boolean goLower) {
        while (low < high) {
            int mid = low + (high - low) / 2;
            boolean hasBlackPixel = false;
            for (int i = top; i < bottom; i++) {
                if (image[i][mid] == '1') {
                    hasBlackPixel = true;
                    break;
                }
            }
            if (hasBlackPixel == goLower) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        return low;
    }

    private int binarySearchRow(char[][] image, int low, int high, int left, int right, boolean goLower) {
        while (low < high) {
            int mid = low + (high - low) / 2;
            boolean hasBlackPixel = false;
            for (int j = left; j < right; j++) {
                if (image[mid][j] == '1') {
                    hasBlackPixel = true;
                    break;
                }
            }
            if (hasBlackPixel == goLower) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        return low;
    }
}