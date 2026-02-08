import java.util.List;
import java.util.ArrayList;
import java.util.Collections;

class Solution {
    public int findMinDifference(List<String> timePoints) {
        if (timePoints.size() > 1440) {
            return 0;
        }

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

        int wrapAroundDiff = (minutes.get(0) + 1440) - minutes.get(minutes.size() - 1);
        minDiff = Math.min(minDiff, wrapAroundDiff);

        return minDiff;
    }
}