import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

class Solution {
    public int solve(int[][] meetings) {
        if (meetings == null || meetings.length == 0) {
            return 0;
        }

        Arrays.sort(meetings, Comparator.comparingInt(a -> a[0]));

        List<int[]> mergedIntervals = new ArrayList<>();

        for (int[] meeting : meetings) {
            if (mergedIntervals.isEmpty() || meeting[0] > mergedIntervals.get(mergedIntervals.size() - 1)[1]) {
                mergedIntervals.add(meeting);
            } else {
                mergedIntervals.get(mergedIntervals.size() - 1)[1] = Math.max(mergedIntervals.get(mergedIntervals.size() - 1)[1], meeting[1]);
            }
        }

        int totalFreeTime = 0;
        for (int i = 1; i < mergedIntervals.size(); i++) {
            totalFreeTime += mergedIntervals.get(i)[0] - mergedIntervals.get(i - 1)[1];
        }

        return totalFreeTime;
    }
}