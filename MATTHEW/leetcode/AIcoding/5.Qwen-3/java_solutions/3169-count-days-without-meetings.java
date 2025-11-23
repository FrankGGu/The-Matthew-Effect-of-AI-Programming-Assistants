public class Solution {

import java.util.*;

public class Solution {
    public int countDaysWithoutMeetings(int[] days) {
        Arrays.sort(days);
        int count = 0;
        for (int i = 1; i < days.length; i++) {
            if (days[i] != days[i - 1] + 1) {
                count++;
            }
        }
        return count;
    }
}
}