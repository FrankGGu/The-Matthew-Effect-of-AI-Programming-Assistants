import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int findMinDifference(List<String> timePoints) {
        List<Integer> minutes = new ArrayList<>();

        for (String timePoint : timePoints) {
            String[] parts = timePoint.split(":");
            int hour = Integer.parseInt(parts[0]);
            int minute = Integer.parseInt(parts[1]);
            minutes.add(hour * 60 + minute);
        }

        Collections.sort(minutes);

        int minDiff = Integer.MAX_VALUE;

        for (int i = 0; i < minutes.size() - 1; i++) {
            minDiff = Math.min(minDiff, minutes.get(i + 1) - minutes.get(i));
        }

        // Handle the wrap-around difference between the last and first time point
        // e.g., "23:59" and "00:00"
        int wrapAroundDiff = (24 * 60) - (minutes.get(minutes.size() - 1) - minutes.get(0));
        minDiff = Math.min(minDiff, wrapAroundDiff);

        return minDiff;
    }
}