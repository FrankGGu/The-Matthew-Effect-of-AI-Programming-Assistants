public class Solution {

import java.util.*;

public class MyCalendar {
    private List<int[]> schedule;

    public MyCalendar() {
        schedule = new ArrayList<>();
    }

    public boolean book(int start, int end) {
        for (int[] s : schedule) {
            if (s[0] < end && s[1] > start) {
                return false;
            }
        }
        schedule.add(new int[]{start, end});
        return true;
    }
}
}