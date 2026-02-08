import java.util.Arrays;

class Solution {
    public int minMeetingRooms(int[][] intervals) {
        int n = intervals.length;
        int[] start = new int[n];
        int[] end = new int[n];
        for (int i = 0; i < n; i++) {
            start[i] = intervals[i][0];
            end[i] = intervals[i][1];
        }
        Arrays.sort(start);
        Arrays.sort(end);
        int rooms = 0;
        int endIdx = 0;
        for (int i = 0; i < n; i++) {
            if (start[i] < end[endIdx]) {
                rooms++;
            } else {
                endIdx++;
            }
        }
        return rooms;
    }
}