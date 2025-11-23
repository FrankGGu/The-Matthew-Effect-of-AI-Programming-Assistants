import java.util.*;

public class Solution {
    public int[][] maxFreeTime(int[][] intervals) {
        List<int[]> freeTimes = new ArrayList<>();
        Arrays.sort(intervals, Comparator.comparingInt(a -> a[0]));

        int end = intervals[0][1];
        for (int i = 1; i < intervals.length; i++) {
            if (intervals[i][0] > end) {
                freeTimes.add(new int[]{end, intervals[i][0]});
            }
            end = Math.max(end, intervals[i][1]);
        }

        return freeTimes.toArray(new int[freeTimes.size()][]);
    }
}