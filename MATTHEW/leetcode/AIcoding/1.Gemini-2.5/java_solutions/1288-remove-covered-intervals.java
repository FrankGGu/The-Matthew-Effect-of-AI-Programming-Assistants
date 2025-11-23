import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int removeCoveredIntervals(int[][] intervals) {
        Arrays.sort(intervals, (a, b) -> {
            if (a[0] == b[0]) {
                return b[1] - a[1];
            }
            return a[0] - b[0];
        });

        int count = 0;
        int prevEnd = -1;

        for (int[] interval : intervals) {
            int currentEnd = interval[1];

            if (currentEnd > prevEnd) {
                count++;
                prevEnd = currentEnd;
            }
        }

        return count;
    }
}