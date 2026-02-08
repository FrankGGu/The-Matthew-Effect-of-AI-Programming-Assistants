import java.util.Arrays;

class Solution {
    public int numberOfPairs(int[][] points) {
        Arrays.sort(points, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });

        int count = 0;
        for (int i = 0; i < points.length; i++) {
            for (int j = i + 1; j < points.length; j++) {
                if (points[i][0] <= points[j][0] && points[i][1] <= points[j][1]) {
                    boolean blocked = false;
                    for (int k = 0; k < points.length; k++) {
                        if (k != i && k != j && points[i][0] <= points[k][0] && points[k][0] <= points[j][0] && points[i][1] <= points[k][1] && points[k][1] <= points[j][1]) {
                            blocked = true;
                            break;
                        }
                    }
                    if (!blocked) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}