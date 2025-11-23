public class Solution {

import java.util.*;

public class MyCalendar {
    private List<int[]> calendar;

    public MyCalendar() {
        calendar = new ArrayList<>();
    }

    public boolean book(int start, int end) {
        for (int[] event : calendar) {
            if (event[0] < end && event[1] > start) {
                return false;
            }
        }
        calendar.add(new int[]{start, end});
        return true;
    }
}
}