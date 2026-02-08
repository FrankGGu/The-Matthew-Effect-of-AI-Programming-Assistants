public class Solution {

import java.util.Arrays;

public class Solution {
    public boolean haveConflict(String[] event1, String[] event2) {
        int start1 = convertTimeToMinutes(event1[0]);
        int end1 = convertTimeToMinutes(event1[1]);
        int start2 = convertTimeToMinutes(event2[0]);
        int end2 = convertTimeToMinutes(event2[1]);

        return !(end1 < start2 || end2 < start1);
    }

    private int convertTimeToMinutes(String time) {
        String[] parts = time.split(":");
        int hours = Integer.parseInt(parts[0]);
        int minutes = Integer.parseInt(parts[1]);
        return hours * 60 + minutes;
    }
}
}