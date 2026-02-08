import java.util.ArrayList;
import java.util.List;

class MyCalendar {

    List<int[]> events;

    public MyCalendar() {
        events = new ArrayList<>();
    }

    public boolean book(int start, int end) {
        for (int[] event : events) {
            if (Math.max(start, event[0]) < Math.min(end, event[1])) {
                return false;
            }
        }
        events.add(new int[]{start, end});
        return true;
    }
}