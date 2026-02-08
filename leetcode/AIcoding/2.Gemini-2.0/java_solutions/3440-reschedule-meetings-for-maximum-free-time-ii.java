import java.util.*;

class Solution {
    public int maxFreeTime(List<List<Integer>> meetings) {
        List<int[]> events = new ArrayList<>();
        for (List<Integer> meeting : meetings) {
            events.add(new int[]{meeting.get(0), 1});
            events.add(new int[]{meeting.get(1), -1});
        }
        Collections.sort(events, (a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);

        int count = 0;
        int maxFreeTime = 0;
        int prevTime = -1;
        boolean first = true;

        for (int[] event : events) {
            if (first) {
                prevTime = event[0];
                first = false;
            } else {
                if (count == 0) {
                    maxFreeTime = Math.max(maxFreeTime, event[0] - prevTime);
                }
                prevTime = event[0];
            }
            count += event[1];
        }

        return maxFreeTime;
    }
}