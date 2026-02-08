import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int intersectionSizeTwo(int[][] intervals) {
        Arrays.sort(intervals, new Comparator<int[]>() {
            public int compare(int[] a, int[] b) {
                if (a[1] == b[1]) {
                    return b[0] - a[0];
                }
                return a[1] - b[1];
            }
        });
        int res = 0;
        int first = -1, second = -1;
        for (int[] interval : intervals) {
            int start = interval[0];
            int end = interval[1];
            if (start > second) {
                res += 2;
                first = end - 1;
                second = end;
            } else if (start > first) {
                res += 1;
                first = second;
                second = end;
            }
        }
        return res;
    }
}