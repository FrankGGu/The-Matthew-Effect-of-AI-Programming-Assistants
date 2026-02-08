import java.util.Arrays;

class Solution {
    public int intersectionSizeTwo(int[][] intervals) {
        Arrays.sort(intervals, (a, b) -> (a[1] == b[1] ? b[0] - a[0] : a[1] - b[1]));
        int n = intervals.length;
        int count = 0;
        int first = intervals[0][1] - 1;
        int second = intervals[0][1];
        count += 2;
        for (int i = 1; i < n; i++) {
            int start = intervals[i][0];
            int end = intervals[i][1];
            if (start <= first) {
                continue;
            } else if (start <= second) {
                count++;
                first = second;
                second = end;
            } else {
                count += 2;
                first = end - 1;
                second = end;
            }
        }
        return count;
    }
}