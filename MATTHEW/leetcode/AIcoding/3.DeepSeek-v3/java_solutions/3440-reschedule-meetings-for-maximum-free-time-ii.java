import java.util.*;

class Solution {
    public int maxFreeTime(List<List<Integer>> schedule) {
        List<int[]> intervals = new ArrayList<>();
        for (List<Integer> meeting : schedule) {
            intervals.add(new int[]{meeting.get(0), meeting.get(1)});
        }
        Collections.sort(intervals, (a, b) -> a[0] - b[0]);

        int maxGap = 0;
        int lastEnd = intervals.get(0)[1];

        for (int i = 1; i < intervals.size(); i++) {
            int[] current = intervals.get(i);
            if (current[0] > lastEnd) {
                maxGap = Math.max(maxGap, current[0] - lastEnd);
            }
            lastEnd = Math.max(lastEnd, current[1]);
        }

        return maxGap;
    }
}