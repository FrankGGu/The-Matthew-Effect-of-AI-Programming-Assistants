import java.util.*;

public class Solution {
    public int findMinDifference(List<String> timePoints) {
        Set<Integer> timeSet = new HashSet<>();
        for (String time : timePoints) {
            String[] parts = time.split(":");
            int minutes = Integer.parseInt(parts[0]) * 60 + Integer.parseInt(parts[1]);
            timeSet.add(minutes);
        }

        if (timeSet.size() != timePoints.size()) {
            return 0;
        }

        List<Integer> times = new ArrayList<>(timeSet);
        Collections.sort(times);
        int minDiff = Integer.MAX_VALUE;

        for (int i = 0; i < times.size(); i++) {
            int diff = (i == times.size() - 1 ? times.get(0) + 1440 : times.get(i + 1)) - times.get(i);
            minDiff = Math.min(minDiff, diff);
        }

        return minDiff;
    }
}