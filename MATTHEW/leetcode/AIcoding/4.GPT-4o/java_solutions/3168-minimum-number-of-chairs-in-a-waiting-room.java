import java.util.Arrays;

public class Solution {
    public int minimumNumberOfChairs(int[][] times) {
        int n = times.length;
        int[] events = new int[n * 2];

        for (int i = 0; i < n; i++) {
            events[i * 2] = times[i][0];     // start time
            events[i * 2 + 1] = times[i][1]; // end time
        }

        Arrays.sort(events);

        int maxChairs = 0;
        int currentChairs = 0;
        int i = 0;

        for (int time : events) {
            while (i < n && times[i][0] == time) {
                currentChairs++;
                i++;
            }
            while (i < n && times[i][1] == time) {
                currentChairs--;
                i++;
            }
            maxChairs = Math.max(maxChairs, currentChairs);
        }

        return maxChairs;
    }
}