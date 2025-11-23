public class Solution {

import java.util.*;

public class MyCalendarIII {
    private TreeMap<Integer, Integer> events;

    public MyCalendarIII() {
        events = new TreeMap<>();
    }

    public int book(int start, int end) {
        events.put(start, events.getOrDefault(start, 0) + 1);
        events.put(end, events.getOrDefault(end, 0) - 1);

        int maxK = 0;
        int currentK = 0;

        for (Map.Entry<Integer, Integer> entry : events.entrySet()) {
            currentK += entry.getValue();
            maxK = Math.max(maxK, currentK);
        }

        return maxK;
    }
}
}