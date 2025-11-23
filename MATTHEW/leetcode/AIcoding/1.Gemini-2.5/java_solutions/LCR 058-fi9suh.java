import java.util.Map;
import java.util.TreeMap;

class MyCalendar {
    private TreeMap<Integer, Integer> calendar;

    public MyCalendar() {
        calendar = new TreeMap<>();
    }

    public boolean book(int start, int end) {
        // Check for an existing event that ends after or at `start`
        // and starts before or at `start`.
        // This covers cases where the new event starts within an existing event.
        // Or where the new event starts at the same time as an existing event.
        Map.Entry<Integer, Integer> prevEntry = calendar.floorEntry(start);
        if (prevEntry != null && prevEntry.getValue() > start) {
            return false;
        }

        // Check for an existing event that starts before `end`
        // and starts after `start`.
        // This covers cases where an existing event starts within the new event's duration.
        // Or where an existing event starts at the same time as the new event's end.
        Map.Entry<Integer, Integer> nextEntry = calendar.ceilingEntry(start);
        if (nextEntry != null && nextEntry.getKey() < end) {
            return false;
        }

        // If no overlap is found, add the new event to the calendar
        calendar.put(start, end);
        return true;
    }
}