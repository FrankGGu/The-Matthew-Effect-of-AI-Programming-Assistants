import java.util.Arrays;

public class Solution {
    public int minArea(char[][] image, int x, int y) {
        int m = image.length, n = image[0].length;
        int left = searchColumns(image, 0, y, 0, m, true);
        int right = searchColumns(image, y + 1, n, 0, m, false);
        int top = searchRows(image, 0, x, left, right, true);
        int bottom = searchRows(image, x + 1, m, left, right, false);
        return (right - left) * (bottom - top);
    }

    private int searchColumns(char[][] image, int low, int high, int top, int bottom, boolean goLower) {
        while (low < high) {
            int mid = low + (high - low) / 2;
            boolean hasBlack = false;
            for (int i = top; i < bottom; i++) {
                if (image[i][mid] == '1') {
                    hasBlack = true;
                    break;
                }
            }
            if (hasBlack == goLower) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        return low;
    }

    private int searchRows(char[][] image, int low, int high, int left, int right, boolean goLower) {
        while (low < high) {
            int mid = low + (high - low) / 2;
            boolean hasBlack = false;
            for (int j = left; j < right; j++) {
                if (image[mid][j] == '1') {
                    hasBlack = true;
                    break;
                }
            }
            if (hasBlack == goLower) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        return low;
    }
}