public class Solution {

import java.util.*;

public class Solution {
    public int maxFreeTime(int[][] intervals) {
        if (intervals == null || intervals.length == 0) return 0;

        Arrays.sort(intervals, (a, b) -> a[0] - b[0]);

        int freeTime = 0;
        int prevEnd = intervals[0][1];

        for (int i = 1; i < intervals.length; i++) {
            int start = intervals[i][0];
            if (start > prevEnd) {
                freeTime += start - prevEnd;
            }
            prevEnd = Math.max(prevEnd, intervals[i][1]);
        }

        return freeTime;
    }
}
}