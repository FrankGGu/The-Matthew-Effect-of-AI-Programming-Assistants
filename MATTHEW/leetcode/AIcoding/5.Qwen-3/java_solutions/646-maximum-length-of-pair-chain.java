public class Solution {

import java.util.Arrays;
import java.util.Comparator;

public class Solution {
    public int findLongestChain(int[][] intervals) {
        Arrays.sort(intervals, Comparator.comparingInt(a -> a[1]));
        int count = 1;
        int lastEnd = intervals[0][1];
        for (int i = 1; i < intervals.length; i++) {
            if (intervals[i][0] > lastEnd) {
                count++;
                lastEnd = intervals[i][1];
            }
        }
        return count;
    }
}
}