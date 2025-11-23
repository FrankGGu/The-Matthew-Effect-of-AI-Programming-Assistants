import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;

class Solution {
    public int countDays(int days, int[][] meetings) {
        if (meetings == null || meetings.length == 0) {
            return days;
        }

        // Sort meetings by their start times
        Arrays.sort(meetings, (a, b) -> Integer.compare(a[0], b[0]));

        List<int[]> mergedIntervals = new ArrayList<>();

        // Add the first meeting to the list of merged intervals
        mergedIntervals.add(meetings[0]);

        // Iterate through the sorted meetings to merge overlapping or adjacent intervals
        for (int i = 1; i < meetings.length; i++) {
            int[] lastMerged = mergedIntervals.get(mergedIntervals.size() - 1);
            int[] currentMeeting = meetings[i];

            // If the current meeting starts on or before the day after the last merged interval ends,
            // it means there's an overlap or adjacency.
            if (currentMeeting[0] <= lastMerged[1] + 1) {
                // Extend the end day of the last merged interval
                lastMerged[1] = Math.max(lastMerged[1], currentMeeting[1]);
            } else {
                // No overlap, add the current meeting as a new interval
                mergedIntervals.add(currentMeeting);
            }
        }

        // Calculate the total number of days covered by all merged meetings,
        // considering the overall `days` period [1, days].
        long effectiveMeetingDays = 0;
        for (int[] interval : mergedIntervals) {
            // Clip the interval to be within [1, days]
            long start = Math.max(1, interval[0]);
            long end = Math.min(days, interval[1]);

            // If the clipped interval is valid (start <= end)
            if (start <= end) {
                effectiveMeetingDays += (end - start + 1);
            }
        }

        // The number of days without meetings is the total number of days minus
        // the effective number of days covered by meetings.
        return (int) (days - effectiveMeetingDays);
    }
}