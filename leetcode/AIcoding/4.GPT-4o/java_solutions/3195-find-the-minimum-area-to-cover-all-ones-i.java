public class Solution {
    public int minArea(char[][] image, int x, int y) {
        int m = image.length, n = image[0].length;
        int left = searchColumns(image, 0, y, 0, m, true);
        int right = searchColumns(image, y + 1, n, 0, m, false);
        int top = searchRows(image, 0, x, left, right, true);
        int bottom = searchRows(image, x + 1, m, left, right, false);
        return (right - left) * (bottom - top);
    }

    private int searchColumns(char[][] image, int lo, int hi, int top, int bottom, boolean goLower) {
        while (lo < hi) {
            int mid = lo + (hi - lo) / 2;
            boolean hasOne = false;
            for (int i = top; i < bottom; i++) {
                if (image[i][mid] == '1') {
                    hasOne = true;
                    break;
                }
            }
            if (hasOne == goLower) {
                hi = mid;
            } else {
                lo = mid + 1;
            }
        }
        return lo;
    }

    private int searchRows(char[][] image, int lo, int hi, int left, int right, boolean goLower) {
        while (lo < hi) {
            int mid = lo + (hi - lo) / 2;
            boolean hasOne = false;
            for (int j = left; j < right; j++) {
                if (image[mid][j] == '1') {
                    hasOne = true;
                    break;
                }
            }
            if (hasOne == goLower) {
                hi = mid;
            } else {
                lo = mid + 1;
            }
        }
        return lo;
    }
}