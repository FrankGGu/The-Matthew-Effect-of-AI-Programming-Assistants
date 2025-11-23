class Solution {
    public int numberOfPairs(int[][] points) {
        Arrays.sort(points, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return b[1] - a[1];
            }
        });

        int count = 0;
        int n = points.length;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int x1 = points[i][0];
                int y1 = points[i][1];
                int x2 = points[j][0];
                int y2 = points[j][1];
                if (y1 < y2) {
                    continue;
                }
                boolean valid = true;
                for (int k = 0; k < n; k++) {
                    if (k == i || k == j) {
                        continue;
                    }
                    int x = points[k][0];
                    int y = points[k][1];
                    if (x >= x1 && x <= x2 && y <= y1 && y >= y2) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    count++;
                }
            }
        }
        return count;
    }
}