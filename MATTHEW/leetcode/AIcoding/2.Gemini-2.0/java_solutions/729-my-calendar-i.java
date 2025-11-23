import java.util.ArrayList;
import java.util.List;

class MyCalendar {

    List<int[]> calendar;

    public MyCalendar() {
        calendar = new ArrayList<>();
    }

    public boolean book(int start, int end) {
        for (int[] event : calendar) {
            if (Math.max(start, event[0]) < Math.min(end, event[1])) {
                return false;
            }
        }
        calendar.add(new int[]{start, end});
        return true;
    }
}