import java.util.Arrays;

class Solution {
    public int numberOfWays(int[][] points) {
        Arrays.sort(points, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });
        int n = points.length;
        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (points[j][1] >= points[i][1]) {
                    boolean valid = true;
                    for (int k = 0; k < n; k++) {
                        if (k != i && k != j) {
                            if ((points[k][0] >= points[i][0] && points[k][0] <= points[j][0]) && (points[k][1] > points[i][1] && points[k][1] < points[j][1])) {
                                valid = false;
                                break;
                            }
                        }
                    }
                    if (valid) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}