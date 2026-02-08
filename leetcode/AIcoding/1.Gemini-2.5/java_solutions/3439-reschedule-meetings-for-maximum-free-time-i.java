import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

class Solution {
    public int maxFreeTime(List<List<Integer>> meetings) {
        if (meetings == null || meetings.isEmpty()) {
            return 0;
        }

        Collections.sort(meetings, Comparator.comparingInt(a -> a.get(0)));

        List<List<Integer>> mergedIntervals = new ArrayList<>();
        mergedIntervals.add(new ArrayList<>(meetings.get(0)));

        for (int i = 1; i < meetings.size(); i++) {
            List<Integer> currentMeeting = meetings.get(i);
            List<Integer> lastMerged = mergedIntervals.get(mergedIntervals.size() - 1);

            if (currentMeeting.get(0) <= lastMerged.get(1)) {
                lastMerged.set(1, Math.max(lastMerged.get(1), currentMeeting.get(1)));
            } else {
                mergedIntervals.add(new ArrayList<>(currentMeeting));
            }
        }

        int maxFree = 0;
        for (int i = 0; i < mergedIntervals.size() - 1; i++) {
            List<Integer> current = mergedIntervals.get(i);
            List<Integer> next = mergedIntervals.get(i + 1);
            maxFree = Math.max(maxFree, next.get(0) - current.get(1));
        }

        return maxFree;
    }
}