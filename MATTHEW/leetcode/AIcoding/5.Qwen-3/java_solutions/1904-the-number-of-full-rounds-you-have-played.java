public class Solution {

import java.util.*;

public class Solution {
    public int numberOfFullRounds(String startTime, String endTime) {
        int start = convertToMinutes(startTime);
        int end = convertToMinutes(endTime);

        if (start > end) {
            end += 24 * 60;
        }

        int fullRounds = (end - start) / 60;
        return fullRounds;
    }

    private int convertToMinutes(String time) {
        String[] parts = time.split(":");
        int hours = Integer.parseInt(parts[0]);
        int minutes = Integer.parseInt(parts[1]);
        return hours * 60 + minutes;
    }
}
}