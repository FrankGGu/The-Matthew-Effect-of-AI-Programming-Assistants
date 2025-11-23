import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int minimumChairs(int[][] times) {
        List<int[]> events = new ArrayList<>();
        for (int[] time : times) {
            events.add(new int[]{time[0], 1});
            events.add(new int[]{time[1], -1});
        }

        Collections.sort(events, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            }
            return a[1] - b[1];
        });

        int currentChairs = 0;
        int maxChairs = 0;

        for (int[] event : events) {
            currentChairs += event[1];
            maxChairs = Math.max(maxChairs, currentChairs);
        }

        return maxChairs;
    }
}