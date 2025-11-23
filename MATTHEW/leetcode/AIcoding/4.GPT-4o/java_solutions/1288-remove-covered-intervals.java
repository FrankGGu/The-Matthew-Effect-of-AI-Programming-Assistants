import java.util.Arrays;

public class Solution {
    public int removeCoveredIntervals(int[][] intervals) {
        Arrays.sort(intervals, (a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);
        int count = 0, end = 0;
        for (int[] interval : intervals) {
            if (interval[1] > end) {
                count++;
                end = interval[1];
            }
        }
        return count;
    }
}