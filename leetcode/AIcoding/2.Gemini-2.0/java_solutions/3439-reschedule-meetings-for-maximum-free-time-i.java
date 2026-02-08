import java.util.*;

class Solution {
    public int maxFreeTime(List<List<Integer>> meetings) {
        List<Integer> events = new ArrayList<>();
        for (List<Integer> meeting : meetings) {
            events.add(meeting.get(0));
            events.add(meeting.get(1));
        }
        Collections.sort(events);

        int maxFreeTime = 0;
        for (int i = 1; i < events.size(); i++) {
            maxFreeTime = Math.max(maxFreeTime, events.get(i) - events.get(i - 1));
        }

        return maxFreeTime;
    }
}