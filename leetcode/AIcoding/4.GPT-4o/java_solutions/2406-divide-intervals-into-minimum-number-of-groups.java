import java.util.Arrays;

class Solution {
    public int minGroups(int[][] intervals) {
        int n = intervals.length;
        int[][] events = new int[n * 2][2];
        for (int i = 0; i < n; i++) {
            events[i * 2][0] = intervals[i][0];
            events[i * 2][1] = 1;
            events[i * 2 + 1][0] = intervals[i][1] + 1;
            events[i * 2 + 1][1] = -1;
        }

        Arrays.sort(events, (a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);

        int maxGroups = 0, currentGroups = 0;
        for (int[] event : events) {
            currentGroups += event[1];
            maxGroups = Math.max(maxGroups, currentGroups);
        }

        return maxGroups;
    }
}