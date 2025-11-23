import java.util.Arrays;

class Solution {
    public int minRectanglesToCoverPoints(int[][] points, int w) {
        Arrays.sort(points, (a, b) -> a[0] - b[0]);
        int res = 0;
        int n = points.length;
        int i = 0;
        while (i < n) {
            int start = points[i][0];
            int end = start + w;
            res++;
            while (i < n && points[i][0] <= end) {
                i++;
            }
        }
        return res;
    }
}