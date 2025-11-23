import java.util.ArrayList;
import java.util.List;

class MyCalendarTwo {
    List<int[]> events;

    public MyCalendarTwo() {
        events = new ArrayList<>();
    }

    public boolean book(int start, int end) {
        for (int[] event : events) {
            if (Math.max(event[0], start) < Math.min(event[1], end)) {
                return false;
            }
        }
        events.add(new int[]{start, end});
        return true;
    }
}