class Solution {
    public int minArea(char[][] image, int x, int y) {
        int m = image.length, n = image[0].length;
        int left = search(image, 0, y, 0, m, true, true);
        int right = search(image, y + 1, n, 0, m, true, false);
        int top = search(image, 0, x, left, right, false, true);
        int bottom = search(image, x + 1, m, left, right, false, false);
        return (right - left) * (bottom - top);
    }

    private int search(char[][] image, int start, int end, int low, int high, boolean horizontal, boolean findLeft) {
        while (start < end) {
            int mid = start + (end - start) / 2;
            boolean hasOne = false;
            if (horizontal) {
                for (int i = low; i < high; i++) {
                    if (image[i][mid] == '1') {
                        hasOne = true;
                        break;
                    }
                }
            } else {
                for (int j = low; j < high; j++) {
                    if (image[mid][j] == '1') {
                        hasOne = true;
                        break;
                    }
                }
            }
            if (hasOne == findLeft) {
                if (findLeft) {
                    end = mid;
                } else {
                    start = mid + 1;
                }
            } else {
                if (findLeft) {
                    start = mid + 1;
                } else {
                    end = mid;
                }
            }
        }
        return start;
    }
}