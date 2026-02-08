import java.util.*;

class Solution {
    public int findMinDifference(List<String> timePoints) {
        Set<Integer> set = new HashSet<>();
        for (String time : timePoints) {
            String[] parts = time.split(":");
            int minutes = Integer.parseInt(parts[0]) * 60 + Integer.parseInt(parts[1]);
            if (!set.add(minutes)) {
                return 0;
            }
        }

        List<Integer> times = new ArrayList<>(set);
        Collections.sort(times);
        int minDiff = Integer.MAX_VALUE;

        for (int i = 1; i < times.size(); i++) {
            minDiff = Math.min(minDiff, times.get(i) - times.get(i - 1));
        }

        minDiff = Math.min(minDiff, 1440 - times.get(times.size() - 1) + times.get(0));

        return minDiff;
    }
}