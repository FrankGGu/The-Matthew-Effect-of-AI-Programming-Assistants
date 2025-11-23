import java.util.*;

public class Solution {
    public int maxFreeTime(int[][] meetings) {
        Arrays.sort(meetings, (a, b) -> a[0] - b[0]);
        int maxFreeTime = 0;
        int end = meetings[0][1];

        for (int i = 1; i < meetings.length; i++) {
            if (meetings[i][0] > end) {
                maxFreeTime += meetings[i][0] - end;
            }
            end = Math.max(end, meetings[i][1]);
        }

        return maxFreeTime;
    }
}