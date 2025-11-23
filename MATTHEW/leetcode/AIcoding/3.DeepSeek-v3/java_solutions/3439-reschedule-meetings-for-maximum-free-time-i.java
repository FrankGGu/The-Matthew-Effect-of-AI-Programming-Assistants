import java.util.*;

class Solution {
    public int maxFreeTime(List<List<Integer>> schedule) {
        List<int[]> intervals = new ArrayList<>();
        for (List<Integer> meeting : schedule) {
            intervals.add(new int[]{meeting.get(0), meeting.get(1)});
        }
        Collections.sort(intervals, (a, b) -> a[0] - b[0]);

        int maxFree = 0;
        int end = intervals.get(0)[1];

        for (int i = 1; i < intervals.size(); i++) {
            int[] curr = intervals.get(i);
            if (curr[0] > end) {
                maxFree = Math.max(maxFree, curr[0] - end);
            }
            end = Math.max(end, curr[1]);
        }

        return maxFree;
    }
}